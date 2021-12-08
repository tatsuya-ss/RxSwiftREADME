//
//  DetailsViewController.swift
//  RxSwiftREADME
//
//  Created by 坂本龍哉 on 2021/12/08.
//

import UIKit

final class DetailsViewController: UIViewController {
    
    @IBOutlet private weak var emojiLabel: UILabel!
    @IBOutlet private weak var checkImage: UIImageView!
    
    private var item: Item!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emojiLabel.text = item.title
        checkImage.image = item.isHidden ? UIImage(systemName: "questionmark.circle.fill") : UIImage(systemName: "checkmark.seal.fill")
    }
    
    init(item: Item) {
        super.init(nibName: String(describing: Self.self), bundle: nil)
        self.item = item
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
