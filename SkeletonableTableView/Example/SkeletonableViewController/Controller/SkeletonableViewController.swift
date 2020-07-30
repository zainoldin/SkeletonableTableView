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
    private var type: SelectionSkeletonType
    private var sections: [SectionType] = [
        .none(rows: [.profile, .circled]),
        .regular(title: "Options", rows: [.option, .option]),
        .regular(title: "Options", rows: [.option])
    ]
    
    private var navigationBarAppearance: HomeNavigationBarAppearance = .dark
    private lazy var tableBackgroundView = TableBackgroundView()
    override var preferredStatusBarStyle: UIStatusBarStyle {
        navigationBarAppearance == .dark ? .lightContent : .default
    }
    
    @IBOutlet weak var tableView: SkeletonableTableView!
    
    init(type: SelectionSkeletonType) {
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
        tableView.register(RegularHeaderView.self, forHeaderFooterViewReuseIdentifier: "\(RegularHeaderView.self)")
        showSkeleton()
    }
    
    private func showSkeleton() {
        switch type {
        case .solid:
            tableView.showSolidSkeleton()
        case .solidAnimated:
            tableView.showSolidSkeletonAnimating()
        case .gradient:
            tableView.skeletonTintColor = .lightGray
            tableView.showGradientedSkeleton(secondaryColor: UIColor.lightGray.withAlphaComponent(0.8))
        case .gradientAnimated:
            tableView.skeletonTintColor = .lightGray
            tableView.showGradientedSkeletonAnimating(secondaryColor: UIColor.lightGray.withAlphaComponent(0.5))
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
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch sections[section] {
        case let .none(rows):
            return rows.count
        case let .regular(_, rows):
            return rows.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch sections[indexPath.section] {
        case let .none(rows):
            switch rows[indexPath.row] {
            case .profile:
                let cell: ProfileCell = tableView.dequeueReusableCell(for: indexPath)
                return cell
            case .circled:
                let cell: CircledCell = tableView.dequeueReusableCell(for: indexPath)
                return cell
            }
        case let .regular(_, rows):
            switch rows[indexPath.row] {
            case .option:
                let cell: OptionCell = tableView.dequeueReusableCell(for: indexPath)
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch sections[section] {
        case .none:
            return nil
        case let .regular(title, _):
            let view: RegularHeaderView = tableView.dequeueReusableHeaderFooterView()
            view.configure(with: title)
            return view
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch sections[section] {
        case .none:
            return 0
        case .regular:
            return 56.0
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.tableBackgroundView.updateSize(by: scrollView.contentOffset)
        let isMovingDown = scrollView.contentOffset.y > Constants.navigationBarColorChangeYCoordinate
        animateNavigationBarTransitionIfNeeded(for: isMovingDown ? .light : .dark)
    }
}
