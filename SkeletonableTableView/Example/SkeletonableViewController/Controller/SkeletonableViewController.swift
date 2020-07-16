//
//  SkeletonableViewController.swift
//  SkeletonableTableView
//
//  Created by Almas Zainoldin on 7/16/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

final class SkeletonableViewController: UIViewController {

    private var type: SkeletonType
    private var rows: [RowType] = [.option, .option, .option]
    
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
    
    @IBAction func startButtonDidTap(_ sender: UIButton) {
        tableView.showAnimatedSkeleton()
    }
    @IBAction func hideButtonDidTap(_ sender: UIButton) {
        tableView.hideSkeleton()
    }
    
    private func setupUI() {
        title = type.rawValue
        tableView.delegate = self
        tableView.dataSource = self
        [OptionCell.self].forEach(tableView.register(cellClass:))
        tableView.showAnimatedSkeleton()
    }
}

extension SkeletonableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch rows[indexPath.row] {
        case .option:
            let cell: OptionCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
        }
    }
}
