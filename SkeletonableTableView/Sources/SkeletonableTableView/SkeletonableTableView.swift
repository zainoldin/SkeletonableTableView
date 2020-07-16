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

public enum SkeletonAnimationDirection {
    case leftToRight
    case rightLeft
    case topBottom
    case bottomTop
    case topLeftBottomRight
    case bottomRightTopLeft
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

    public override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setup()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    /// Shows the animated skeleton with default tint color on the SkeletonableTableView.
    ///
    /// if animation is nil, pulse animation will be used.
    ///
    /// - Parameters:
    ///   - animation: The animation of the skeleton. Defaults to `nil`.
    ///   - transition: The style of the transition when the skeleton appears. Defaults to `.none`.
    public func showAnimatedSkeleton(animation: SkeletonLayerAnimation? = nil, transition: SkeletonTransitionStyle = .none) {
        reloadData()
        isHidden = true
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.isHidden = false
            self.isScrollEnabled = false
            self.showAnimatedSkeletonOnVisibleCells(animation: animation, transition: transition)
        }
    }
    
    /// Hides the  skeleton on the SkeletonableTableView.
    public func hideSkeleton() {
        isScrollEnabled = true
        hideAnimatedSkeletonOnVisibleCells()
        reloadData()
        beginUpdates()
        endUpdates()
    }
    
    private func showAnimatedSkeletonOnVisibleCells(animation: SkeletonLayerAnimation?, transition: SkeletonTransitionStyle) {
        for cell in visibleCells {
            cell.isUserInteractionEnabled = false
            guard let skeletonableCell = cell as? SkeletonableTableViewCell else {
                cell.showAnimatedSkeleton(usingColor: skeletonTintColor, animation: animation, transition: transition)
                return
            }
            skeletonableCell.showAnimatedSkeleton(animation: animation, transition: transition)
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
