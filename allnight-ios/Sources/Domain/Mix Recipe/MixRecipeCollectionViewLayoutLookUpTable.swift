//
//  MixRecipeCollectionViewLayoutLookUpTable.swift
//  allnight-ios
//
//  Created by 다람쥐 on 22/08/2019.
//  Copyright © 2019 kanghoon. All rights reserved.
//

import UIKit

private let RecipeCollectionViewSingleLayout: UICollectionViewFlowLayout = {
  let layout = UICollectionViewFlowLayout()
  
  layout.sectionInset = UIEdgeInsets(top: MarginTopInSingle, left: MarginLeftInSingle, bottom: MarginBottomInSingle, right: MarginRightInSingle)
  layout.minimumLineSpacing = SpacingLineInSingle
  layout.minimumInteritemSpacing = SpacingItemInSingle
  
  return layout
}()

private let RecipeCollectionViewMultipleLayout: UICollectionViewFlowLayout = {
  let layout = UICollectionViewFlowLayout()
  
  layout.sectionInset = UIEdgeInsets(top: MarginTopInMultiple, left: MarginLeftInMultiple, bottom: MarginBottomInMultiple, right: MarginRightInMultiple)
  layout.minimumLineSpacing = SpacingLineInMultiple
  layout.minimumInteritemSpacing = SpacingItemInMultiple
  
  return layout
}()

func loadRecipeCollectionLayout(recipeMode: MixRecipeMode) -> UICollectionViewFlowLayout {
  if recipeMode == .SingleMode {
    return RecipeCollectionViewSingleLayout
  }
  else if recipeMode == .MultipleMode {
    return RecipeCollectionViewMultipleLayout
  }
  
  return UICollectionViewFlowLayout()
}
