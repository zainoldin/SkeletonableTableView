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
    /// SkeletonableTableView uses `SkeletonAppearance.default.tintColor` to show skeleton on all cells, but you can override this method and set the color you want to specific cell
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
    
    /// Shows the solid animated skeleton on the SkeletonableTableViewCell.
    ///
    /// If animation is nil, pulse animation will be used.
    /// SkeletonableTableView uses `SkeletonAppearance.default.tintColor` to show skeleton on all cells, but you can override this method and set the color you want to specific cell
    ///
    /// - Parameters:
    ///   - color: The color of skeleton. Defaults to `SkeletonAppearance.default.tintColor`.
    ///   - transition: The style of the transition when the skeleton appears. Defaults to `.none`.
    open func showSolidSkeleton(color: UIColor = SkeletonAppearance.default.tintColor,
                                transition: SkeletonTransitionStyle = .none) {
        showSkeleton(usingColor: color, transition: transition)
    }
    
    /// Shows the gradient skeleton without animation on the SkeletonableTableViewCell.
    ///
    /// SkeletonableTableView uses `SkeletonAppearance.default.gradient` to show skeleton on all cells, but you can override this method and set the color you want to specific cell
    ///
    /// - Parameters:
    ///   - gradient: The gradient of skeleton. Defaults to `SkeletonAppearance.default.gradient`.
    ///   - transition: The style of the transition when the skeleton appears. Defaults to `.none`.
    open func showGradientedSkeleton(gradient: SkeletonGradient = SkeletonAppearance.default.gradient,
                                     transition: SkeletonTransitionStyle = .none) {
        showGradientSkeleton(usingGradient: gradient, transition: transition)
    }
    
    /// Shows the gradient animated skeleton on the SkeletonableTableViewCell.
    ///
    /// SkeletonableTableView uses `SkeletonAppearance.default.gradient` to show skeleton on all cells, but you can override this method and set the color you want to specific cell
    ///
    /// - Parameters:
    ///   - gradient: The gradient of skeleton. Defaults to `SkeletonAppearance.default.gradient`.
    ///   - gradientDirection: The gradient of skeleton. Defaults to `.leftRight`.
    ///   - duration: The duration of the animation. Defaults to `1.5`.
    ///   - transition: The style of the transition when the skeleton appears. Defaults to `.none`.
    open func showGradientedSkeletonAnimating(gradient: SkeletonGradient = SkeletonAppearance.default.gradient,
                                              gradientDirection: GradientDirection = .leftRight,
                                              duration: Double = 1.5,
                                              transition: SkeletonTransitionStyle = .none) {
        let animation = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: gradientDirection, duration: duration)
        showAnimatedGradientSkeleton(usingGradient: gradient, animation: animation, transition: transition)
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
    /// If your child class is relized programatically you should call this method in init functions (child class) to make all needed subviews skeletonable. Otherwise do nothing
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
