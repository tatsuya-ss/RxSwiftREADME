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
    @IBOutlet private weak var textField1: UITextField!
    @IBOutlet private weak var textField2: UITextField!
    @IBOutlet private weak var loginButton: UIButton!
    
    private var searchBarTextDidChangeEvent: Observable<String>?
    private let disposeBag = DisposeBag()
    
    private var validateEvent: Observable<Bool> {
        return Observable.combineLatest(textField1.rx.text.orEmpty, textField2.rx.text.orEmpty)
            .map { [$0, $1].allSatisfy { !$0.isEmpty } }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        setupSearchBarEvent()
        
        validateEvent
            .subscribe(onNext: { isEnabled in
                self.changeLoginButtonState(isEnabled: isEnabled)
            })
            .disposed(by: disposeBag)
        
//        Observable.combineLatest(textField1.rx.text.orEmpty, textField2.rx.text.orEmpty)
//            .map { [$0, $1].allSatisfy { !$0.isEmpty } }
//            .subscribe(onNext: { isEnabled in
//                self.changeLoginButtonState(isEnabled: isEnabled)
//            })
//            .disposed(by: disposeBag)
        
    }
    
    @IBAction private func didTapLoginButton(_ sender: Any) {
        print(#function)
    }
}

// MARK: - func
extension WithoutRxCoccoaViewController {
    private func changeLoginButtonState(isEnabled: Bool) {
        loginButton.isEnabled = isEnabled
        loginButton.backgroundColor = isEnabled ? .systemRed : .systemGray
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
