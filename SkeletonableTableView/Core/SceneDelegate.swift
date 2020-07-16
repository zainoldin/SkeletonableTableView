//
//  SceneDelegate.swift
//  SkeletonableTableView
//
//  Created by Almas Zainoldin on 7/5/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = UINavigationController(rootViewController: SkeletonTypeSelectionViewController())
        window?.makeKeyAndVisible()
        setupNavigationBar()
    }

    private func setupNavigationBar() {
        let navigationBar = UINavigationBar.appearance()
        navigationBar.isTranslucent = false
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.barTintColor = .white
    }
}

