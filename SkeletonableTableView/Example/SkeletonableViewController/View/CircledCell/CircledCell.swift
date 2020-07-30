//
//  CircledCell.swift
//  SkeletonableTableView
//
//  Created by Almas Zainoldin on 7/19/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

class CircledCell: SkeletonableTableViewCell {
    @IBOutlet private var blackLineView: UIView!
    @IBOutlet private var conainerView: UIView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var stackView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // SkeletonableTableView makes skeletonable only subviews of contentView as default, but you can ovveride it and change skeletonable configuration for specific views
    override func setupSkeletonableViews() {
        super.setupSkeletonableViews()
        let views: [UIView] = [[conainerView], conainerView.subviews, stackView.arrangedSubviews].flatMap { $0 }
        views.forEach { $0.isSkeletonable = true }
        blackLineView.isSkeletonable = false
    }
}
