//
//  SkeletonableTableViewCell.swift
//  SkeletonableTableView
//
//  Created by Almas Zainoldin on 7/15/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import SkeletonView
import UIKit

open class SkeletonableTableViewCell: UITableViewCell {
    open override func awakeFromNib() {
        super.awakeFromNib()
        setupSkeletonableViews()
    }

    open override func prepareForReuse() {
        super.prepareForReuse()
        hideSkeleton()
    }
    
    /// Shows the solid animated skeleton on the SkeletonableTableViewCell.
    ///
    /// If animation is nil, `pulse` animation will be used.
    /// There is possibility to override function and change skeleton appearance configuration of  current cell
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
    /// There is possibility to override function and change skeleton appearance configuration of  current cell
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
    /// There is possibility to override function and change skeleton appearance configuration of  current cell
    ///
    /// - Parameters:
    ///   - baseColor: The base color of gradient. Defaults to `SkeletonAppearance.default.tintColor`.
    ///   - secondaryColor: The secondary color of gradient. Defaults to `.nil`.
    ///   - transition: The style of the transition when the skeleton appears. Defaults to `.none`.
    open func showGradientedSkeleton(baseColor: UIColor = SkeletonAppearance.default.tintColor,
                                     secondaryColor: UIColor? = nil,
                                     transition: SkeletonTransitionStyle = .none) {
        let gradient = SkeletonGradient(baseColor: baseColor, secondaryColor: secondaryColor)
        showGradientSkeleton(usingGradient: gradient, transition: transition)
    }
    
    /// Shows the gradient animated skeleton on the SkeletonableTableViewCell.
    ///
    /// There is possibility to override function and change skeleton appearance configuration of  current cell
    ///
    /// - Parameters:
    ///   - baseColor: The base color of gradient. Defaults to `SkeletonAppearance.default.tintColor`.
    ///   - secondaryColor: The secondary color of gradient. Defaults to `.nil`.
    ///   - gradientDirection: The animation direction of skeleton. Defaults to `.leftRight`.
    ///   - duration: The duration of the animation. Defaults to `1.5`.
    ///   - transition: The style of the transition when the skeleton appears. Defaults to `.none`.
    open func showGradientedSkeletonAnimating(baseColor: UIColor = SkeletonAppearance.default.tintColor,
                                              secondaryColor: UIColor? = nil,
                                              gradientDirection: GradientDirection = .leftRight,
                                              duration: Double = 1.5,
                                              transition: SkeletonTransitionStyle = .none) {
        let gradient = SkeletonGradient(baseColor: baseColor, secondaryColor: secondaryColor)
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

    /// Setup initial skeleton appearance configurations of cell
    ///
    /// If your child class is relized programatically you should call this method in init functions (child class) to make all needed subviews skeletonable. Otherwise do nothing
    ///
    /// This method makes skeletonable only subviews of contentView as default, but there is possibility to override function and change skeleton appearance configuration of specific views
    open func setupSkeletonableViews() {
        var views = contentView.subviews
        views.append(self)
        views.forEach { view in
            view.isSkeletonable = true
            view.skeletonCornerRadius = Float(SkeletonAppearance.default.multilineCornerRadius)
        }
    }
}
