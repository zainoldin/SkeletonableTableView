//
//  SkeletonableHeaderFooterView.swift
//  SkeletonableTableView
//
//  Created by Almas Zainoldin on 7/20/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import SkeletonView
import UIKit

private enum Constants {
    static let cornerRadius: Float = 4.0
}

// Important: add all UI Elemetns to contentView, not to root view. Otherwise, only rootView will be skeletoned and not work as expected.
// I suggest to realize your custom UITableViewHeaderFooterView programatically as I couldn't find way to add UI elements to contentView by interface builder
open class SkeletonableHeaderFooterView: UITableViewHeaderFooterView {
            
    open override func prepareForReuse() {
        super.prepareForReuse()
        hideSkeleton()
    }
    
    /// Shows the solid animated  skeleton on the SkeletonableTableViewCell.
    ///
    /// If animation is nil, pulse animation will be used.
    /// SkeletonableTableView uses `SkeletonAppearance.default.tintColor` to show skeleton on all cels, but you can override this method and set the color you want to specific cell
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
    
    /// Shows the solid animated  skeleton on the SkeletonableTableViewCell.
    ///
    /// If animation is nil, pulse animation will be used.
    /// SkeletonableTableView uses `SkeletonAppearance.default.tintColor` to show skeleton on all cels, but you can override this method and set the color you want to specific cell
    ///
    /// - Parameters:
    ///   - color: The color of skeleton. Defaults to `SkeletonAppearance.default.tintColor`.
    ///   - transition: The style of the transition when the skeleton appears. Defaults to `.none`.
    open func showSolidSkeleton(color: UIColor = SkeletonAppearance.default.tintColor,
                                         transition: SkeletonTransitionStyle = .none) {
        showSkeleton(usingColor: color, transition: transition)
    }
    
    /// Hides the skeleton on the SkeletonableTableViewCell.
    ///
    /// - Parameters:
    ///   - transition: The style of the transition when the skeleton appears. Defaults to `.none`.
    open func hideSkeleton(transition: SkeletonTransitionStyle = .none) {
        hideSkeleton(reloadDataAfter: false, transition: transition)
    }
    
    /// Setup initial skeletonable configurations of view
    ///
    /// If your child class is relized programatically you should call this method in init functions (child class) to make all needed subviews skeletonable. Otherwise do nothing
    ///
    /// This method makes skeletonable only subviews of current view as default, but you can ovveride it and change skeletonable configuration for specific views
    open func setupSkeletonableViews() {
        var views = contentView.subviews
        views.append(self)
        views.forEach { view in
            view.isSkeletonable = true
            view.skeletonCornerRadius = Constants.cornerRadius
        }
    }
}

