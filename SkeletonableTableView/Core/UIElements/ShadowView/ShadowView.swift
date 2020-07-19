//
//  ShadowView.swift
//  SkeletonableTableView
//
//  Created by Almas Zainoldin on 7/19/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

private enum Constants {
    static let cornerRadius: CGFloat = 4
    static let shadowOpacity: Float = 1
    static let shadowRadius: CGFloat = 20
    static let shadowColor = UIColor.black.withAlphaComponent(0.06)
}

class ShadowView: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()
        updateShadow()
    }

    private func updateShadow() {
        let size = CGSize(width: Constants.cornerRadius, height: Constants.cornerRadius)
        let shadowPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.allCorners], cornerRadii: size).cgPath
        layer.shadowPath = shadowPath
        layer.shadowColor = Constants.shadowColor.cgColor
        layer.shadowOffset = .zero
        layer.shadowOpacity = Constants.shadowOpacity
        layer.shadowRadius = Constants.shadowRadius
    }
}
