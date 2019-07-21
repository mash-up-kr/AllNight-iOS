//
//  RecipeCollectionViewCell.swift
//  allnight-ios
//
//  Created by 다람쥐 on 21/07/2019.
//  Copyright © 2019 kanghoon. All rights reserved.
//

import UIKit

protocol RecipeCollectionViewCellDelegate: class {
  func tapStar(tapped:Bool)
}

class RecipeCollectionViewCell: UICollectionViewCell {
    
  weak var cellDelegate: RecipeCollectionViewCellDelegate?
  
  @IBOutlet weak var image: UIImageView!
  
  @IBOutlet weak var detailView: UIView!
  
  @IBOutlet weak var typeLabel: UILabel!
  
  @IBOutlet weak var nameLabel: UILabel!
  
  @IBOutlet weak var starButton: UIButton!
  
  private var starSelected: Bool = false
  
  override func awakeFromNib() {
    
  }
  
  @IBAction func tapStar(_ sender: Any) {
    if !starSelected {
        starButton.setImage(#imageLiteral(resourceName: "icFilledStar"), for: .normal)
    } else {
        starButton.setImage(#imageLiteral(resourceName: "icUnfilledStar"), for: .normal)
    }
  
    cellDelegate?.tapStar(tapped: starSelected)
    starSelected.toggle()
  }
  
}
