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
  
  @IBOutlet weak var imageView: UIImageView!
  
  @IBOutlet weak var detailView: UIView!
  
  @IBOutlet weak var typeLabel: UILabel!
  
  @IBOutlet weak var nameLabel: UILabel!
  
  @IBOutlet weak var starButton: UIButton!
  
  private var starSelected: Bool = false
  
  var recipeMode: MixRecipeMode = .SingleMode
  
  @IBOutlet weak var detailViewHeightConstraint: NSLayoutConstraint!
  
  
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
  
  func setImage(_ image: UIImage)
  {
    imageView.image = image
    layoutIfNeeded()
  }
  
  func changeMode(_ mode: MixRecipeMode)
  {
    if (mode == recipeMode)
    {
      return
    }
    
    recipeMode = mode
    
    if (recipeMode == .MultipleMode)
    {
      nameLabel.font = nameLabel.font.withSize(20.0)
      
      detailViewHeightConstraint.constant = 74.0
    }
    else if (recipeMode == .SingleMode)
    {
      nameLabel.font = nameLabel.font.withSize(39.0)
      
    detailViewHeightConstraint.constant = 155.0
    }
    
    layoutIfNeeded()
  }
  
}
