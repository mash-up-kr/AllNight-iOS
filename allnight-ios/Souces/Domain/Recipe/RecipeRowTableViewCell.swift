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

    func configure(ingredientName: String, measure: String) {
        nameLabel.text = ingredientName
        amountLabel.text = measure
    }
    
    func changeBottomConstraint(constraint: CGFloat) {
        bottomLayoutConstraint.constant = constraint
    }
}
