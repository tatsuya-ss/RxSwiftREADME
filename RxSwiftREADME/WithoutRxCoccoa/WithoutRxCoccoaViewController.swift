//
//  WithoutRxCoccoaViewController.swift
//  RxSwiftREADME
//
//  Created by 坂本龍哉 on 2021/12/06.
//

import UIKit
import RxSwift

final class WithoutRxCoccoaViewController: UIViewController {

    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var displayLabel: UILabel!
    
    private var searchBarTextDidChangeEvent: Observable<String>?
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        setupSearchBarEvent()
    }
    
}

// MARK: -
extension WithoutRxCoccoaViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBarTextDidChangeEvent?.subscribe(onNext: { text in
            self.displayLabel.text = text
        })
            .disposed(by: disposeBag)
    }
}

// MARK: - setup
extension WithoutRxCoccoaViewController {
    
    private func setupSearchBarEvent() {
        searchBarTextDidChangeEvent = Observable<String>.create { observer in
            observer.on(.next(self.searchBar.text ?? "入力無し"))
            return Disposables.create()
        }
    }
    
}

// MARK: - instantiate
extension WithoutRxCoccoaViewController {
    
    static func instantiate() -> WithoutRxCoccoaViewController {
        guard let withoutRxCoccoaVC = UIStoryboard(name: "WithoutRxCoccoa", bundle: nil)
                .instantiateViewController(withIdentifier: "WithoutRxCoccoaViewController")
                as? WithoutRxCoccoaViewController
        else { fatalError("WithoutRxCoccoaViewControllerが見つかりません。") }
        return withoutRxCoccoaVC
    }

}
