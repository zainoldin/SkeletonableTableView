//
//  SkeletonType.swift
//  SkeletonableTableView
//
//  Created by Almas Zainoldin on 7/20/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import SkeletonView
import Foundation

public enum SkeletonType {
    case solid
    case solidAnimated(animation: SkeletonLayerAnimation?)
    case gradient(secondaryColor: UIColor?)
}
