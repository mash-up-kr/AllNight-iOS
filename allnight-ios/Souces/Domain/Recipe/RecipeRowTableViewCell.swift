//
//  RecipeRowTableViewCell.swift
//  allnight-ios
//
//  Created by Suji Kim on 11/07/2019.
//  Copyright © 2019 kanghoon. All rights reserved.
//

import UIKit

class RecipeRowTableViewCell: UITableViewCell {
    @IBOutlet weak var bottomLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func config() {
        nameLabel.text = "Sweet Vermouth"
        amountLabel.text = "1/2 oz"
    }
    
    func changeBottomConstraint(constraint: CGFloat) {
        bottomLayoutConstraint.constant = constraint
    }
}
