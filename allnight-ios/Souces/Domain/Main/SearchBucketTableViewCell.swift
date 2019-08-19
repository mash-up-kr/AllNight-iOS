//
//  InCartTableViewCell.swift
//  allnight-ios
//
//  Created by 공지원 on 18/08/2019.
//  Copyright © 2019 kanghoon. All rights reserved.
//

import UIKit

class SearchBucketTableViewCell: UITableViewCell {
    
    //MARK: - Property
    var delegate: SearchBucketViewController?
    var ingredientsArr = Array(CocktailManager.shared.ingredientsInBucket)
    
    //MARK: - IBOutlet
    @IBOutlet var ingredientNameLabel: UILabel!
    
    func configure(indexPath: IndexPath) {
        ingredientNameLabel.text = ingredientsArr[indexPath.row]
    }
    
    @IBAction func removeButtonDidTap(_ sender: UIButton) {
        print("removeButtonDidTap")
       
        //model 변경
        if let ingredientToRemove = ingredientNameLabel.text {
            CocktailManager.shared.ingredientsInBucket.remove(ingredientToRemove)
        }
        
        delegate?.handleRemoveButton(cell: self)
    }
}
