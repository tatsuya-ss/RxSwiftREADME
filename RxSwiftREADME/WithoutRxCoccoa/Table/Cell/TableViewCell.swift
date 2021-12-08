//
//  TableViewCell.swift
//  RxSwiftREADME
//
//  Created by 坂本龍哉 on 2021/12/07.
//

import UIKit

final class TableViewCell: UITableViewCell {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var checkImage: UIImageView!
    
    static var identifier: String { String(describing: self) }
    static var nib: UINib { UINib(nibName: String(describing: self), bundle: nil) }
    
    func configure(item: Item) {
        titleLabel.text = item.title
        checkImage.isHidden = item.isHidden
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
