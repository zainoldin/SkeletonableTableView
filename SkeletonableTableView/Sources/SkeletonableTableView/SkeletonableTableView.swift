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
    @IBInspectable public var skeletonTintColor: UIColor = .lightGray {
        didSet {
            SkeletonAppearance.default.tintColor = skeletonTintColor
        }
    }

    @IBInspectable public var multilineCornerRadius: Int = Constants.cornerRadius {
        didSet {
            SkeletonAppearance.default.multilineCornerRadius = multilineCornerRadius
        }
    }
    
    private enum SkeletonType {
        case solid
        case solidAnimated(animation: SkeletonLayerAnimation?)
    }

    public override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setup()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    /// Shows the solid animated skeleton with default tint color on the SkeletonableTableView.
    ///
    /// if animation is nil, pulse animation will be used.
    ///
    /// - Parameters:
    ///   - animation: The animation of the skeleton. Defaults to `nil`.
    ///   - transition: The style of the transition when the skeleton appears. Defaults to `.none`.
    public func showSolidSkeletonAnimating(animation: SkeletonLayerAnimation? = nil, transition: SkeletonTransitionStyle = .none) {
        showSkeleton(with: .solidAnimated(animation: animation), transition: transition)
    }
    
    /// Shows the solid skeleton without animation and with default tint color on the SkeletonableTableView.
    ///
    /// - Parameters:
    ///   - transition: The style of the transition when the skeleton appears. Defaults to `.none`.
    public func showSolidSkeleton(transition: SkeletonTransitionStyle = .none) {
        showSkeleton(with: .solid, transition: transition)
    }
    
    /// Hides the  skeleton on the SkeletonableTableView.
    public func hideSkeletonAnimating() {
        isScrollEnabled = true
        hideAnimatedSkeletonOnVisibleCells()
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
                }
                return
            }
            switch type {
            case .solid:
                skeletonableCell.showSolidSkeleton(color: skeletonTintColor, transition: transition)
            case let .solidAnimated(animation):
                skeletonableCell.showSolidSkeletonAnimating(color: skeletonTintColor,animation: animation, transition: transition)
            }
        }
    }
    
    private func hideAnimatedSkeletonOnVisibleCells() {
        for cell in visibleCells {
            cell.isUserInteractionEnabled = true
            guard let skeletonableCell = cell as? SkeletonableTableViewCell else {
                cell.hideSkeleton()
                return
            }
            skeletonableCell.hideSkeleton()
        }
    }

    private func setup() {
        tableFooterView = UIView()
        isSkeletonable = true
        SkeletonAppearance.default.multilineCornerRadius = Constants.cornerRadius
    }
}
