//
//  SearchTableViewCell.swift
//  allnight-ios
//
//  Created by 공지원 on 16/08/2019.
//  Copyright © 2019 kanghoon. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    var isInCart = false {
        didSet {
            if isInCart {
                putInCartButton.setImage(UIImage(named: "icPutincart24Normal"), for: .normal)
            } else {
                putInCartButton.setImage(UIImage(named: "icPutincart24Disactive"), for: .normal)
            }
        }
    }
    
    var delegate: SearchViewController?
    
    //MARK: - IBOutlet 
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var putInCartButton: UIButton!
    
    override func prepareForReuse() {
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func putInCartButtonDidTap(_ sender: UIButton) {
        print("putInCartButtonDidTap")
        delegate?.handlePutInCartButton()
        
        sender.isSelected = !sender.isSelected
        isInCart = sender.isSelected
    }
}
