//
//  SkeletonableTableView.swift
//  SkeletonableTableView
//
//  Created by Almas Zainoldin on 7/15/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import SkeletonView
import UIKit

private enum Constants {
    static let cornerRadius = 4
}

public final class SkeletonableTableView: UITableView {
    
    /// The color of skeleton (used as base color in gradient skeleton). Defaults to `.skeletonDefault`.
    @IBInspectable public var skeletonTintColor: UIColor = .skeletonDefault {
        didSet {
            SkeletonAppearance.default.tintColor = skeletonTintColor
        }
    }

    /// The corner radius of skeletoned labels . Defaults to `4`.
    @IBInspectable public var multilineCornerRadius: Int = Constants.cornerRadius {
        didSet {
            prefferedMultilineCornerRadius = multilineCornerRadius
            SkeletonAppearance.default.multilineCornerRadius = multilineCornerRadius
        }
    }
    
    private var prefferedMultilineCornerRadius = Constants.cornerRadius
    
    public override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setup()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    /// Shows the animated solid skeleton with skeletonTintColor on the SkeletonableTableView.
    ///
    /// if animation is nil, pulse animation will be used.
    ///
    /// - Parameters:
    ///   - animation: The animation of the skeleton. Defaults to `nil`.
    ///   - transition: The style of the transition when the skeleton appears. Defaults to `.none`.
    public func showSolidSkeletonAnimating(animation: SkeletonLayerAnimation? = nil, transition: SkeletonTransitionStyle = .none) {
        showSkeleton(with: .solidAnimated(animation: animation), transition: transition)
    }
    
    /// Shows the solid skeleton without animation and with skeletonTintColor on the SkeletonableTableView.
    ///
    /// - Parameters:
    ///   - transition: The style of the transition when the skeleton appears. Defaults to `.none`.
    public func showSolidSkeleton(transition: SkeletonTransitionStyle = .none) {
        showSkeleton(with: .solid, transition: transition)
    }
    
    /// Shows the gradient skeleton without animation on the SkeletonableTableView.
    ///
    /// - Parameters:
    ///   - secondaryColor: The secondary color of gradient, base color is set by skeletonTintColor. Defaults to `.nil`.
    ///   - transition: The style of the transition when the skeleton appears. Defaults to `.none`.
    public func showGradientedSkeleton(secondaryColor: UIColor? = nil, transition: SkeletonTransitionStyle = .none) {
        showSkeleton(with: .gradient(secondaryColor: secondaryColor), transition: transition)
    }
    
    /// Shows the animated gradient skeleton on the SkeletonableTableView.
    ///
    /// - Parameters:
    ///   - secondaryColor: The secondary color of gradient, base color is set by skeletonTintColor. Defaults to `.nil`.
    ///   - transition: The style of the transition when the skeleton appears. Defaults to `.none`.
    func showGradientedSkeletonAnimating(secondaryColor: UIColor? = nil,
                                         gradientDirection: GradientDirection = .leftRight,
                                         duration: Double = 1.5,
                                         transition: SkeletonTransitionStyle = .none) {
        showSkeleton(with: .grarientAnimated(secondaryColor: secondaryColor, direction: gradientDirection, duration: duration), transition: transition)
    }
    
    /// Hides the  skeleton on the SkeletonableTableView.
    public func hideSkeletonAnimating() {
        isScrollEnabled = true
        hideSkeletonOnVisibleCells()
        hideSkeletonOnVisibleHeaderFooterViews()
        reloadData()
    }
    
    private func showSkeleton(with type: SkeletonType, transition: SkeletonTransitionStyle) {
        isHidden = true
        reloadData()
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.isHidden = false
            self.isScrollEnabled = false
            self.showSkeletonOnVisibleCells(with: type, transition: transition)
            self.showSkeletonOnVisibleHeaderFooterViews(with: type, transition: transition)
        }
    }
    
    private func showSkeletonOnVisibleCells(with type: SkeletonType, transition: SkeletonTransitionStyle) {
        for cell in visibleCells {
            cell.isUserInteractionEnabled = false
            guard let skeletonableCell = cell as? SkeletonableTableViewCell else {
                switch type {
                case .solid:
                    cell.showSkeleton(usingColor: skeletonTintColor, transition: transition)
                case let .solidAnimated(animation):
                    cell.showAnimatedSkeleton(usingColor: skeletonTintColor, animation: animation, transition: transition)
                case let .gradient(secondaryColor):
                    let gradient = SkeletonGradient(baseColor: skeletonTintColor, secondaryColor: secondaryColor)
                    cell.showGradientSkeleton(usingGradient: gradient, transition: transition)
                case let .grarientAnimated(secondaryColor, direction, duration):
                    let gradient = SkeletonGradient(baseColor: skeletonTintColor, secondaryColor: secondaryColor)
                    let animation = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: direction, duration: duration)
                    cell.showAnimatedGradientSkeleton(usingGradient: gradient, animation: animation, transition: transition)
                }
                continue
            }
            switch type {
            case .solid:
                skeletonableCell.showSolidSkeleton(color: skeletonTintColor, transition: transition)
            case let .solidAnimated(animation):
                skeletonableCell.showSolidSkeletonAnimating(color: skeletonTintColor,animation: animation, transition: transition)
            case let .gradient(secondaryColor):
                let gradient = SkeletonGradient(baseColor: skeletonTintColor, secondaryColor: secondaryColor)
                skeletonableCell.showGradientedSkeleton(gradient: gradient, transition: transition)
            case let .grarientAnimated(secondaryColor, direction, duration):
                let gradient = SkeletonGradient(baseColor: skeletonTintColor, secondaryColor: secondaryColor)
                skeletonableCell.showGradientedSkeletonAnimating(gradient: gradient, gradientDirection: direction, duration: duration, transition: transition)
            }
        }
    }
    
    private func hideSkeletonOnVisibleCells() {
        for cell in visibleCells {
            cell.isUserInteractionEnabled = true
            guard let skeletonableCell = cell as? SkeletonableTableViewCell else {
                cell.hideSkeleton()
                continue
            }
            skeletonableCell.hideSkeleton()
        }
    }
    
    private func showSkeletonOnVisibleHeaderFooterViews(with type: SkeletonType, transition: SkeletonTransitionStyle) {
        let headerFooterViews = getVisibleHeaderFooterViews()
        for headerFooterView in headerFooterViews {
            headerFooterView.isUserInteractionEnabled = false
            guard let skeletonableHeaderFooterView = headerFooterView as? SkeletonableHeaderFooterView else {
                switch type {
                case .solid:
                    headerFooterView.showSkeleton(usingColor: skeletonTintColor, transition: transition)
                case let .solidAnimated(animation):
                    headerFooterView.showAnimatedSkeleton(usingColor: skeletonTintColor, animation: animation, transition: transition)
                case let .gradient(secondaryColor):
                    let gradient = SkeletonGradient(baseColor: skeletonTintColor, secondaryColor: secondaryColor)
                    headerFooterView.showGradientSkeleton(usingGradient: gradient, transition: transition)
                case let .grarientAnimated(secondaryColor, direction, duration):
                    let gradient = SkeletonGradient(baseColor: skeletonTintColor, secondaryColor: secondaryColor)
                    let animation = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: direction, duration: duration)
                    headerFooterView.showAnimatedGradientSkeleton(usingGradient: gradient, animation: animation, transition: transition)
                }
                continue
            }
            switch type {
            case .solid:
                skeletonableHeaderFooterView.showSolidSkeleton(color: skeletonTintColor, transition: transition)
            case let .solidAnimated(animation):
                skeletonableHeaderFooterView.showSolidSkeletonAnimating(color: skeletonTintColor,animation: animation, transition: transition)
            case let .gradient(secondaryColor):
                let gradient = SkeletonGradient(baseColor: skeletonTintColor, secondaryColor: secondaryColor)
                skeletonableHeaderFooterView.showGradientedSkeleton(gradient: gradient, transition: transition)
            case let .grarientAnimated(secondaryColor, direction, duration):
                let gradient = SkeletonGradient(baseColor: skeletonTintColor, secondaryColor: secondaryColor)
                skeletonableHeaderFooterView.showGradientedSkeletonAnimating(gradient: gradient, gradientDirection: direction, duration: duration, transition: transition)
            }
        }
    }
    
    
    private func hideSkeletonOnVisibleHeaderFooterViews() {
        let headerFooterViews = getVisibleHeaderFooterViews()
        for headerFooterView in headerFooterViews {
            headerFooterView.isUserInteractionEnabled = true
            guard let skeletonableHeaderFooterView = headerFooterView as? SkeletonableHeaderFooterView else {
                headerFooterView.hideSkeleton()
                continue
            }
            skeletonableHeaderFooterView.hideSkeleton()
        }
    }
        
    private func setup() {
        tableFooterView = UIView()
        isSkeletonable = true
        SkeletonAppearance.default.multilineCornerRadius = prefferedMultilineCornerRadius
    }
    
    private func getVisibleHeaderFooterViews() -> [UITableViewHeaderFooterView] {
        guard let visibleRows = indexPathsForVisibleRows else { return [] }
        let visibleSectionIndexes = visibleRows.map { $0.section }.removeDuplicates()
        return visibleSectionIndexes.compactMap { headerView(forSection: $0) }
    }
}

private extension Array where Element: Equatable {
    func removeDuplicates() -> [Element] {
        var result: [Element] = []
        for value in self where !result.contains(value) {
            result.append(value)
        }
        return result
    }
}
