//
//  ProfileCell.swift
//  SkeletonableTableView
//
//  Created by Almas Zainoldin on 7/19/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import SkeletonView
import UIKit

final class ProfileCell: SkeletonableTableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // I override this function to make different skeleton appearance configuration for this cell
    override func showSolidSkeletonAnimating(color: UIColor = SkeletonAppearance.default.tintColor,
                                             animation: SkeletonLayerAnimation? = nil,
                                             transition: SkeletonTransitionStyle = .none) {
        super.showSolidSkeletonAnimating(color: .bgPrimaryLighten, animation: animation, transition: transition)
    }
    
    override func showSolidSkeleton(color: UIColor = SkeletonAppearance.default.tintColor,
                                    transition: SkeletonTransitionStyle = .none) {
        super.showSkeleton(usingColor: .bgPrimaryLighten, transition: transition)
    }
    
    override func showGradientedSkeleton(baseColor: UIColor = SkeletonAppearance.default.tintColor,
                                         secondaryColor: UIColor? = nil,
                                         transition: SkeletonTransitionStyle = .none) {
        super.showGradientedSkeleton(baseColor: .bgPrimaryLighten,
                                     secondaryColor: UIColor.bgPrimaryLighten.withAlphaComponent(0.7),
                                     transition: transition)
    }
    
    override func showGradientedSkeletonAnimating(baseColor: UIColor = SkeletonAppearance.default.tintColor,
                                                  secondaryColor: UIColor? = nil,
                                                  gradientDirection: GradientDirection = .leftRight,
                                                  duration: Double = 1.5,
                                                  transition: SkeletonTransitionStyle = .none) {
        super.showGradientedSkeletonAnimating(baseColor: .bgPrimaryLighten,
                                              secondaryColor: UIColor.bgPrimaryLighten.withAlphaComponent(0.7),
                                              gradientDirection: .rightLeft,
                                              duration: duration,
                                              transition: transition)
        
    }
}
