//
//  SkeletonableHeaderFooterView.swift
//  SkeletonableTableView
//
//  Created by Almas Zainoldin on 7/20/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import SkeletonView
import UIKit

// Important: add all UIViews to contentView, not to root view. Otherwise, only rootView will be skeletoned and wouldn't work as expected.
// I suggest to implement your custom UITableViewHeaderFooterView programatically as I couldn't find way to add UIViews to contentView by Interface Builder
open class SkeletonableHeaderFooterView: UITableViewHeaderFooterView {
            
    open override func prepareForReuse() {
        super.prepareForReuse()
        hideSkeleton()
    }
    
    /// Shows the solid animated  skeleton on the SkeletonableHeaderFooterView.
    ///
    /// If animation is `nil`, pulse animation will be used.
    /// You can override function and change skeleton appearance configuration of current view
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
    
    /// Shows the solid animated  skeleton on the SkeletonableHeaderFooterView.
    ///
    /// If animation is `nil`, pulse animation will be used.
    /// You can override function and change skeleton appearance configuration of  current view
    ///
    /// - Parameters:
    ///   - color: The color of skeleton. Defaults to `SkeletonAppearance.default.tintColor`.
    ///   - transition: The style of the transition when the skeleton appears. Defaults to `.none`.
    open func showSolidSkeleton(color: UIColor = SkeletonAppearance.default.tintColor,
                                transition: SkeletonTransitionStyle = .none) {
        showSkeleton(usingColor: color, transition: transition)
    }
    
    /// Shows the gradient skeleton without animation on the SkeletonableHeaderFooterView.
    ///
    /// You can override function and change skeleton appearance configuration of current view
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
    
    /// Shows the gradient animated skeleton on the SkeletonableHeaderFooterView.
    ///
    /// You can override function and change skeleton appearance configuration of current view
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
    
    /// Hides the skeleton on the SkeletonableHeaderFooterView.
    ///
    /// - Parameters:
    ///   - transition: The style of the transition when the skeleton appears. Defaults to `.none`.
    open func hideSkeleton(transition: SkeletonTransitionStyle = .none) {
        hideSkeleton(reloadDataAfter: false, transition: transition)
    }
    
    /// Setup initial skeleton appearance configurations of cell
    ///
    /// If your child class is implemented programmatically you should call this method in initializer methods of derived class to mark all necessary subviews as skeletonable.
    ///
    /// This method by default marks only subviews of contentView as skeletonable.
    /// You can override it and tweak the marking behavior if you need
    open func setupSkeletonableViews() {
        var views = contentView.subviews
        views.append(self)
        views.forEach { view in
            view.isSkeletonable = true
            view.skeletonCornerRadius = Float(SkeletonAppearance.default.multilineCornerRadius)
        }
    }
}

