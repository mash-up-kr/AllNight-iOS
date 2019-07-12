//
//  DetailInformationTableViewCell.swift
//  allnight-ios
//
//  Created by Suji Kim on 11/07/2019.
//  Copyright © 2019 kanghoon. All rights reserved.
//

import UIKit

class DetailInformationTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func config(title: String, detail: String) {
        titleLabel.text = title
        detailLabel.text = detail
    }
}
