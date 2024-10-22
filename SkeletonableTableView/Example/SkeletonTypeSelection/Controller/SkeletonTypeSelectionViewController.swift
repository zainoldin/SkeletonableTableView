//
//  SkeletonTypeSelectionViewController.swift
//  SkeletonableTableView
//
//  Created by Almas Zainoldin on 7/16/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

enum SelectionSkeletonType: String {
    case solid = "Solid"
    case solidAnimated = "Solid Animated"
    case gradient = "Gradient"
    case gradientAnimated = "Gradient Animated"
}

final class SkeletonTypeSelectionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.barTintColor = .white
    }
    
    @IBAction func solidButtonDidTap(_ sender: UIButton) {
        let viewController = SkeletonableViewController(type: .solid)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func solidAnimatedButtonDidTap(_ sender: UIButton) {
        let viewController = SkeletonableViewController(type: .solidAnimated)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func gradientButtonDidTap(_ sender: UIButton) {
        let viewController = SkeletonableViewController(type: .gradient)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func gradientAnimatedButtonDidTap(_ sender: UIButton) {
        let viewController = SkeletonableViewController(type: .gradientAnimated)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
