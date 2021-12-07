//
//  TableViewController.swift
//  RxSwiftREADME
//
//  Created by 坂本龍哉 on 2021/12/07.
//

import UIKit

final class TableViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    init() {
        super.init(nibName: String(describing: TableViewController.self),
                   bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - setup
extension TableViewController {
    
    private func setupTableView() {
        tableView.register(TableViewCell.nib,
                           forCellReuseIdentifier: TableViewCell.identifier)
    }
    
}
