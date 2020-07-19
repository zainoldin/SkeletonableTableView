//
//  SkeletonableViewController.swift
//  SkeletonableTableView
//
//  Created by Almas Zainoldin on 7/16/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

enum HomeNavigationBarAppearance {
    case dark
    case light
}

private enum Constants {
    static let navigationBarAnimationDuration: TimeInterval = 0.2
    static let navigationBarColorChangeYCoordinate: CGFloat = 92.0
}

final class SkeletonableViewController: UIViewController {
    private var type: SkeletonType
    private var rows: [RowType] = [.profile, .circled, .option, .option, .option, .option]
    private var navigationBarAppearance: HomeNavigationBarAppearance = .dark
    private lazy var tableBackgroundView = TableBackgroundView()
    override var preferredStatusBarStyle: UIStatusBarStyle {
        navigationBarAppearance == .dark ? .lightContent : .default
    }
    
    @IBOutlet weak var tableView: SkeletonableTableView!
    
    init(type: SkeletonType) {
        self.type = type
        super.init(nibName: String(describing: Self.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateNavigationBarAppearance()
    }
    
    @IBAction func startButtonDidTap(_ sender: UIButton) {
        showSkeleton()
    }
    @IBAction func hideButtonDidTap(_ sender: UIButton) {
        tableView.hideSkeletonAnimating()
    }
    
    private func setupUI() {
        title = type.rawValue
        tableView.backgroundView = tableBackgroundView
        tableView.delegate = self
        tableView.dataSource = self
        [
            OptionCell.self,
            ProfileCell.self,
            CircledCell.self
        ].forEach(tableView.register(cellClass:))
        showSkeleton()
    }
    
    private func showSkeleton() {
        switch type {
        case .solid:
            tableView.showSolidSkeleton()
        case .solidAnimated:
            tableView.showSolidSkeletonAnimating()
        case .gradiend:
            break
        }
    }
    
    private func updateNavigationBarAppearance() {
        navigationController?.navigationBar.barTintColor = navigationBarAppearance == .dark ? .txPrimary : .white
        navigationController?.navigationBar.barStyle = navigationBarAppearance == .dark ? .black : .default
        navigationController?.navigationBar.tintColor = navigationBarAppearance == .dark ? .white : .txPrimary
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: navigationBarAppearance == .dark ? UIColor.white : UIColor.txPrimary]
    }
    
    private func animateNavigationBarTransitionIfNeeded(for newApperance: HomeNavigationBarAppearance) {
        guard navigationBarAppearance != newApperance else { return }
        navigationBarAppearance = newApperance
        updateNavigationBarAppearance()
        UIView.animate(withDuration: Constants.navigationBarAnimationDuration) {
            self.setNeedsStatusBarAppearanceUpdate()
            self.navigationController?.navigationBar.layoutIfNeeded()
        }
    }
}

extension SkeletonableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch rows[indexPath.row] {
        case .profile:
            let cell: ProfileCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
        case .circled:
            let cell: CircledCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
        case .option:
            let cell: OptionCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.tableBackgroundView.updateSize(by: scrollView.contentOffset)
        let isMovingDown = scrollView.contentOffset.y > Constants.navigationBarColorChangeYCoordinate
        animateNavigationBarTransitionIfNeeded(for: isMovingDown ? .light : .dark)
    }
}
