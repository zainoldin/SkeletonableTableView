//
//  UIView+NibLoading.swift
//  SkeletonableTableView
//
//  Created by Almas Zainoldin on 7/5/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

protocol NibIdentifiable: class {
    static var nibName: String { get }
}

extension NibIdentifiable {
    static var nibName: String {
        String(describing: self)
    }
}

protocol NibLoadable: NibIdentifiable {
    static var nib: UINib { get }
}

extension NibLoadable {
    static var nib: UINib {
        UINib(nibName: nibName, bundle: Bundle(for: self))
    }
}

extension NibLoadable where Self: UIView {
    static func loadFromNib() -> Self {
        guard let view = nib.instantiate(withOwner: nil, options: nil).first as? Self else {
            fatalError("The nib \(nib) expected its root view to be of type \(self)")
        }
        return view
    }
}

protocol NibOwnerLoadable: NibIdentifiable {
    static var nib: UINib { get }
}

extension NibOwnerLoadable {
    static var nib: UINib {
        UINib(nibName: nibName, bundle: Bundle(for: self))
    }
}

extension NibOwnerLoadable where Self: UIView {
    func loadNibContent() {
        let layoutAttributes: [NSLayoutConstraint.Attribute] = [.top, .leading, .bottom, .trailing]
        for case let view as UIView in type(of: self).nib.instantiate(withOwner: self, options: nil) {
            view.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(view)
            NSLayoutConstraint.activate(layoutAttributes.map {
                NSLayoutConstraint(item: view, attribute: $0, relatedBy: .equal, toItem: self, attribute: $0, multiplier: 1, constant: 0)
            })
        }
    }
}

