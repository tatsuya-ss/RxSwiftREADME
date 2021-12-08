//
//  TableViewController.swift
//  RxSwiftREADME
//
//  Created by 坂本龍哉 on 2021/12/07.
//

import UIKit
import RxSwift

final class TableViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    private var items: Observable<[Item]> {
        Observable<[Item]>
            .of([Item(title: "🍎", isHidden: true), Item(title: "🦍", isHidden: false)])
    }
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupTableViewCell()
        setupTableViewActions()
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
    
    private func setupTableViewActions() {
        // MARK: セルタップ処理
        tableView.rx.itemSelected
            .subscribe(onNext: { indexPath in
                self.pushToDetailsVC(indexPath: indexPath)
            })
            .disposed(by: disposeBag)
    }
    
    private func pushToDetailsVC(indexPath: IndexPath) {
        items.subscribe(onNext: { items in
            let detailsVC = DetailsViewController(item: items[indexPath.row])
            self.navigationController?.pushViewController(detailsVC, animated: true)
        })
            .disposed(by: disposeBag)
    }
    
    private func setupTableViewCell() {
        items
            .bind(to: tableView.rx.items(cellIdentifier: TableViewCell.identifier, cellType: TableViewCell.self)) { row, element, cell in
                cell.configure(item: element)
            }
            .disposed(by: disposeBag)
    }
    
    private func setupTableView() {
        tableView.register(TableViewCell.nib,
                           forCellReuseIdentifier: TableViewCell.identifier)
    }
    
}
