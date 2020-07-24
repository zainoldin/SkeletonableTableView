//
//  RegularHeaderView.swift
//  SkeletonableTableView
//
//  Created by Almas Zainoldin on 7/20/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

final class RegularHeaderView: SkeletonableHeaderFooterView {
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupUI()
        setupSkeletonableViews()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    func configure(with title: String) {
        self.titleLabel.text = title
    }
    
    private func setupUI() {
        contentView.backgroundColor = .white
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
}
