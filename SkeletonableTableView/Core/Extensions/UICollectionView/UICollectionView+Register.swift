//
//  UICollectionView+Register.swift
//  SkeletonableTableView
//
//  Created by Almas Zainoldin on 7/5/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

public extension UICollectionView {
    func register(cellClass: AnyClass) {
        let nib = UINib(nibName: "\(cellClass)", bundle: Bundle(for: cellClass))
        register(nib, forCellWithReuseIdentifier: "\(cellClass)")
    }

    func register(supplementaryViewClass: AnyClass) {
        let nib = UINib(nibName: "\(supplementaryViewClass)", bundle: Bundle(for: supplementaryViewClass))
        register(nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "\(supplementaryViewClass)")
    }
}
