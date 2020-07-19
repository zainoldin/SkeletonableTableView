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
    
    /// Shows the solid animated  skeleton on the SkeletonableTableViewCell.
    ///
    /// If animation is nil, pulse animation will be used.
    /// SkeletonableTableView uses `SkeletonAppearance.default.tintColor` to show animation on all cels, but you can override this method and set the color you want to specific cell
    ///
    /// - Parameters:
    ///   - color: The color of skeleton. Defaults to `SkeletonAppearance.default.tintColor`.
    ///   - animation: The animation of the skeleton. Defaults to `nil`. 
    ///   - transition: The style of the transition when the skeleton appears. Defaults to `.none`.
    open func showSolidSkeletonAnimating(color: UIColor = SkeletonAppearance.default.tintColor,
                                         animation: SkeletonLayerAnimation? = nil,
                                         transition: SkeletonTransitionStyle = .none) {
        showAnimatedSkeleton(usingColor: color, animation: nil, transition: transition)
    }

    /// Hides the skeleton on the SkeletonableTableViewCell.
    ///
    /// - Parameters:
    ///   - transition: The style of the transition when the skeleton appears. Defaults to `.none`.
    open func hideSkeleton(transition: SkeletonTransitionStyle = .none) {
        hideSkeleton(reloadDataAfter: false, transition: transition)
    }

    /// Setup initial skeletonable configurations of cell
    ///
    /// This method makes skeletonable only subviews of contentView as default, but you can ovveride it and change skeletonable configuration for specific views
    open func setupSkeletonableViews() {
        var views = contentView.subviews
        views.append(self)
        views.forEach { view in
            view.isSkeletonable = true
            view.skeletonCornerRadius = Constants.cornerRadius
        }
    }
}
