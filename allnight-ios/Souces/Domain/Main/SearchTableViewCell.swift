//
//  SearchTableViewCell.swift
//  allnight-ios
//
//  Created by 공지원 on 16/08/2019.
//  Copyright © 2019 kanghoon. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    //MARK: - Property
    private let isInCartIconName = "icPutincart24Normal"
    private let isNotInCartIconName = "icPutincart24Disactive"
    
    var isInCart = false {
        didSet {
            if isInCart {
                putInCartButton.setImage(UIImage(named: isInCartIconName), for: .normal)
            } else {
                putInCartButton.setImage(UIImage(named: isNotInCartIconName), for: .normal)
            }
        }
    }

    //MARK: - IBOutlet 
    @IBOutlet var ingredientNameLabel: UILabel!
    @IBOutlet var putInCartButton: UIButton!
    
    override func prepareForReuse() {
        isInCart = false
    }
    
    func configure(result: String) {
        ingredientNameLabel.text = result
        
        if CocktailManager.shared.ingredientsInBucket.contains(result) {
            isInCart = true
        }
    }
    
    @IBAction func putInCartButtonDidTap(_ sender: UIButton) {
        
        guard let ingredient = ingredientNameLabel.text else { return }
        
        if isInCart { //이미 카트에 담겨있던 재료라면
            isInCart = false; //View 수정
            CocktailManager.shared.ingredientsInBucket.remove(ingredient) //Model 수정
        } else { //카트에 없던 재료라면
            isInCart = true; //View 수정
            CocktailManager.shared.ingredientsInBucket.insert(ingredient) //Model 수정
        }
    }
}
