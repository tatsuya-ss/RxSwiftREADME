//
//  ViewController.swift
//  RxSwiftREADME
//
//  Created by 坂本龍哉 on 2021/12/04.
//

import UIKit
import RxSwift
import RxCocoa

final class ViewController: UIViewController {
    
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var resultLabel: UILabel!
    
    private let disposeBag = DisposeBag()
    private var searchBarEvent: Observable<String>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // RxCocoa
        setupSearchBar()
        resultLabel.text = "入力なし"
        
        // Observable作成
//        searchBarEvent = makeSearchBarObservable()
//        searchBar.delegate = self
    }
    
}

// MARK: -
extension ViewController: UISearchBarDelegate {
    // Observable作成
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBarEvent?
            .subscribe(onNext: { text in
                self.resultLabel.text = text
            })
            .disposed(by: disposeBag)
    }
    
}

// MARK: - func
extension ViewController {
    // RxCocoa
    private func setupSearchBar() {
        searchBar.rx.text.orEmpty
            .subscribe(onNext: { text in
                self.resultLabel.text = text
            })
            .disposed(by: disposeBag)
    }
    
    // Observable作成
    private func makeSearchBarObservable() -> Observable<String> {
        return Observable<String>.create { observer in
            observer.on(.next(self.searchBar.text ?? "入力無し"))
            return Disposables.create()
        }
    }
    
}
