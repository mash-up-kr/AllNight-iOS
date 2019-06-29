//
//  SearchResultTableViewCell.swift
//  allnight-ios
//
//  Created by SungMinJung on 30/06/2019.
//  Copyright © 2019 kanghoon. All rights reserved.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var resultLabel: UILabel!
    @IBOutlet private weak var resultCart: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(text: String) {
        resultLabel.text = text
    }

}
