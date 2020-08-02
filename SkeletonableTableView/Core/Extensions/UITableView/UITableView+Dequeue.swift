//
//  UITableView+Dequeue.swift
//  SkeletonableTableView
//
//  Created by Almas Zainoldin on 7/5/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

extension UITableView {
    func dequeueReusableCell<Cell: UITableViewCell>(for indexPath: IndexPath) -> Cell {
        guard let cell = dequeueReusableCell(withIdentifier: "\(Cell.self)", for: indexPath) as? Cell else {
            fatalError("register(cellClass:) has not been implemented")
        }
        return cell
    }

    func dequeueReusableHeaderFooterView<View: UITableViewHeaderFooterView>() -> View {
        guard let view = dequeueReusableHeaderFooterView(withIdentifier: "\(View.self)") as? View else {
            fatalError("register(aClass:) has not been implemented")
        }
        return view
    }
}
