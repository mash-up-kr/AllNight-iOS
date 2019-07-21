//
//  MixRecipeViewController.swift
//  allnight-ios
//
//  Created by ohkanghoon on 29/06/2019.
//  Copyright © 2019 kanghoon. All rights reserved.
//

import UIKit

enum MixRecipeMode: String, CaseIterable {
    case SingleMode
    case MultipleMode
}

final class MixRecipeViewController: UIViewController {

  @IBOutlet weak var topView: UIView!
    
  @IBOutlet weak var homeButton: UIButton!
  
  @IBOutlet weak var filterButton: UIButton!
  
  @IBOutlet weak var modeButton: UIButton!
  
  @IBOutlet weak var recipeCollectionView: UICollectionView!
  
  let filterPopupView = FilterPopupView()
  
  @IBAction func tapHome(_ sender: Any) {
    
  }
  
  @IBAction func tapFilter(_ sender: Any) {
    
  }
  
  @IBAction func tapMode(_ sender: Any) {
    
  }
  
  
  // MARK: View LifeCycle

  override func viewDidLoad() {
    super.viewDidLoad()
    
    recipeCollectionView.delegate   = self
    recipeCollectionView.dataSource = self
  }
}

// MARK: CollectionView LifeCycle

extension MixRecipeViewController: UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 5
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecipeCollectionViewCell", for: indexPath) as? RecipeCollectionViewCell else {
      return UICollectionViewCell()
    }
    
    return cell
  }
}

extension MixRecipeViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
    return false
  }
}

extension MixRecipeViewController: RecipeCollectionViewCellDelegate {
  func tapStar(tapped: Bool) {
    // TODO: 즐겨찾기 기능 만들기
    if tapped {
      
    } else {
      
    }
  }
}
