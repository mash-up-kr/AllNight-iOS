//
//  RecipeCollectionViewCell.swift
//  allnight-ios
//
//  Created by 다람쥐 on 21/07/2019.
//  Copyright © 2019 kanghoon. All rights reserved.
//

import UIKit
import Kingfisher

protocol RecipeCollectionViewCellDelegate: class {
  func tapScrap(cell: RecipeCollectionViewCell)
}

class RecipeCollectionViewCell: UICollectionViewCell {
    
  weak var cellDelegate: RecipeCollectionViewCellDelegate?
  
  @IBOutlet weak var imageView: UIImageView!
  
  @IBOutlet weak var detailView: GradientView!
  
  @IBOutlet weak var typeLabel: UILabel!
  
  @IBOutlet weak var nameLabel: UILabel!
  
  @IBOutlet weak var scrapButton: UIButton!
  
  @IBOutlet weak var alcoholicImgView: UIImageView!
  
  private let scrappedIconName = "icScrap24Normal-1"
  private let nonScrappedIconName = "icScrap24Normal"
  private let alcholicIconName = "icAlcholic"
  
  var isScrap = false {
    didSet {
      if isScrap {
        scrapButton.setImage(UIImage(named: scrappedIconName), for: .normal)
      } else {
        scrapButton.setImage(UIImage(named: nonScrappedIconName), for: .normal)
      }
    }
  }
  
  var recipeMode: MixRecipeMode = .SingleMode
  
  private var starSelected: Bool = false
  
  @IBOutlet weak var detailViewHeightConstraint: NSLayoutConstraint!
  
  override func prepareForReuse() {
    imageView.image = nil
    nameLabel.text = ""
    scrapButton.setImage(UIImage(named: nonScrappedIconName), for: .normal)
  }
  
  @IBAction func tapScrap(_ sender: Any) {
    isScrap.toggle()
    cellDelegate?.tapScrap(cell: self)
  }
  
  func configure(indexPath: IndexPath, cocktailInfo: Cocktail) {
    
    //칵테일 썸네일 이미지 설정
    let thumbUrl = cocktailInfo.drinkThumb
    imageView.kf.setImage(with: thumbUrl)
    
    //칵테일 이름 설정
    nameLabel.text = cocktailInfo.drinkName
    
    //알코올 유무 표시 이미지 설정
    typeLabel.text = cocktailInfo.alcoholic
    
    //스크랩 유무에 따른 아이콘 설정
    if CocktailManager.shared.scrappedCocktails.contains(cocktailInfo.id) {
      isScrap = true
    }
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
