//
//  SkeletonableTableViewCell.swift
//  SkeletonableTableView
//
//  Created by Almas Zainoldin on 7/15/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import SkeletonView
import UIKit

private enum Constants {
    static let cornerRadius: Float = 4.0
}

open class SkeletonableTableViewCell: UITableViewCell {
    open override func awakeFromNib() {
        super.awakeFromNib()
        setupSkeletonableViews()
    }

    open override func prepareForReuse() {
        super.prepareForReuse()
        hideSkeleton()
    }
    
    /// Shows the animated skeleton with default tint color on the SkeletonableTableViewCell.
    ///
    /// if animation is nil, pulse animation will be used.
    ///
    /// - Parameters:
    ///   - animation: The animation of the skeleton. Defaults to `nil`. 
    ///   - transition: The style of the transition when the skeleton appears. Defaults to `.none`.
    open func showAnimatedSkeleton(animation: SkeletonLayerAnimation? = nil, transition: SkeletonTransitionStyle = .none) {
        showAnimatedSkeleton(usingColor: SkeletonAppearance.default.tintColor, animation: nil, transition: transition)
    }

    /// Hides the skeleton on the SkeletonableTableViewCell.
    ///
    /// - Parameters:
    ///   - transition: The style of the transition when the skeleton appears. Defaults to `.crossDissolve(0.25)`.
    open func hideSkeleton(transition: SkeletonTransitionStyle = .crossDissolve(0.25)) {
        hideSkeleton(reloadDataAfter: false, transition: transition)
    }

    open func setupSkeletonableViews() {
        var views = contentView.subviews
        views.append(self)
        views.forEach { view in
            view.isSkeletonable = true
            view.skeletonCornerRadius = Constants.cornerRadius
        }
    }
}
