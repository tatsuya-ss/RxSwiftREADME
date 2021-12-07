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
    @IBOutlet private weak var textField1: UITextField!
    @IBOutlet private weak var textField2: UITextField!
    @IBOutlet private weak var loginButton: UIButton!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        setupTextValidate()
    }
    
}

// MARK: - func
extension ViewController {
    
    private func setupTextValidate() {
        Observable
            .combineLatest(
                textField1.rx.text.orEmpty,
                textField2.rx.text.orEmpty
            )
            .map { [$0, $1].allSatisfy { !$0.isEmpty } }
            .subscribe(onNext: { isEnable in
                self.changeLoginButtonState(isEnable: isEnable)
            })
            .disposed(by: disposeBag)
    }
    
    private func changeLoginButtonState(isEnable: Bool) {
        loginButton.isEnabled = isEnable
        loginButton.backgroundColor = isEnable ? .systemYellow : .systemGray
    }
    
    private func setupSearchBar() {
        searchBar.rx.text.orEmpty
            .subscribe(onNext: { text in
                self.resultLabel.text = text
            })
            .disposed(by: disposeBag)
    }
    
}

// MARK: - instantiate
extension ViewController {
    
    static func instantiate() -> ViewController {
        guard let VC = UIStoryboard(name: "Main", bundle: nil)
                .instantiateViewController(withIdentifier: "ViewController")
                as? ViewController
        else { fatalError("ViewControllerが見つかりません。") }
        return VC
    }
    
}
