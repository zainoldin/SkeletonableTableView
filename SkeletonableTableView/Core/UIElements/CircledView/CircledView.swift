//
//  CircledView.swift
//  SkeletonableTableView
//
//  Created by Almas Zainoldin on 7/19/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

class CircledView: UIView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.height / 2
        layer.masksToBounds = true
    }
}
