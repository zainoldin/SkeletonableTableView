//
//  TableBackgroundView.swift
//  SkeletonableTableView
//
//  Created by Almas Zainoldin on 7/19/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

class TableBackgroundView: UIView {
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .txPrimary
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        nil
    }

    func updateSize(by contentOffset: CGPoint) {
        let contentYOffset = contentOffset.y
        contentView.frame.size = contentYOffset < 0 ? CGSize(width: frame.width, height: -contentYOffset) : .zero
    }

    private func setup() {
        addSubview(contentView)
    }
}

