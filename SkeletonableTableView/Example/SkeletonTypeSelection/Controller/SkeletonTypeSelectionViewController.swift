//
//  SkeletonTypeSelectionViewController.swift
//  SkeletonableTableView
//
//  Created by Almas Zainoldin on 7/16/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

enum SkeletonType: String {
    case solid = "Solid"
    case solidAnimated = "Solid Animated"
    case gradiend = "Gradient"
}


final class SkeletonTypeSelectionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.barTintColor = .white
    }
    @IBAction func solidButtonDidTap(_ sender: UIButton) {
        
    }
    
    @IBAction func solidAnimatedButtonDidTap(_ sender: UIButton) {
        let viewController = SkeletonableViewController(type: .solidAnimated)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func gradientButtonDidTap(_ sender: UIButton) {
        
    }
}
