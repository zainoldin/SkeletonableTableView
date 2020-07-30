//
//  UICollectionView+Dequeue.swift
//  SkeletonableTableView
//
//  Created by Almas Zainoldin on 7/5/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

extension UICollectionView {
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: "\(T.self)", for: indexPath) as? T else {
            fatalError("register(cellClass:) has not been implemented")
        }
        return cell
    }

    func dequeueReusableSupplementaryView<T: UICollectionReusableView>(ofKind elementKind: String, for indexPath: IndexPath) -> T {
        guard let view = dequeueReusableSupplementaryView(ofKind: elementKind, withReuseIdentifier: "\(T.self)", for: indexPath) as? T else {
            fatalError("register(aClass:) has not been implemented")
        }
        return view
    }
}
