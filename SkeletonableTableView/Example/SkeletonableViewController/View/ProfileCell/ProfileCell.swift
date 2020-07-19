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
    
    // SkeletonableTableView uses `SkeletonAppearance.default.tintColor` to show animation on all cels, but you can override this method and set the color you want to specific cell
    override func showSolidSkeletonAnimating(color: UIColor = SkeletonAppearance.default.tintColor,
                                             animation: SkeletonLayerAnimation? = nil,
                                             transition: SkeletonTransitionStyle = .none) {
        super.showSolidSkeletonAnimating(color: .bgPrimaryLighten, animation: animation, transition: transition)
    }
}
