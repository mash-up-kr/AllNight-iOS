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
  
  mutating func toggle() {
    if self == .SingleMode {
      self = .MultipleMode
    }
    else {
      self = .SingleMode
    }
  }
}

final class MixRecipeViewController: UIViewController {

  @IBOutlet weak var topView: UIView!
    
  @IBOutlet weak var homeButton: UIButton!
  
  @IBOutlet weak var filterButton: UIButton!
  
  @IBOutlet weak var modeButton: UIButton!
  
  @IBOutlet weak var recipeCollectionView: UICollectionView!
  
  let FilterPopup = FilterPopupView()
  
  let ScreenWidth = UIScreen.main.bounds.width
  
  var recipeMode = MixRecipeMode.SingleMode
  
  @IBAction func tapHome(_ sender: Any) {
    
  }
  
  @IBAction func tapFilter(_ sender: Any) {
    
  }
  
  @IBAction func tapMode(_ sender: Any) {
    recipeMode.toggle()
    
    setModeImage(recipeMode: recipeMode)
     recipeCollectionView.setCollectionViewLayout(loadRecipeCollectionLayout(recipeMode: recipeMode), animated: false)
  }
  
  func setModeImage(recipeMode: MixRecipeMode) {
    if recipeMode == .SingleMode {
      modeButton.setImage(#imageLiteral(resourceName: "icMultiple"), for: .normal)
    }
    else {
      modeButton.setImage(#imageLiteral(resourceName: "icSingle"), for: .normal)
    }
  }
  
  // MARK: View LifeCycle

  override func viewDidLoad() {
    super.viewDidLoad()
    
    recipeCollectionView.delegate   = self
    recipeCollectionView.dataSource = self
    
    AllNightNetworking().request(.search(ingredient: "맥주"), completionHandler: { (Response) in
      if let data = try? Response.decodeJSON(Array<String>.self).get() {
        print(data)
      }
    }) { (MoyaError) in
      print(MoyaError.errorDescription ?? "")
    }
    
    setModeImage(recipeMode: recipeMode)
    recipeCollectionView.setCollectionViewLayout(loadRecipeCollectionLayout(recipeMode: recipeMode), animated: true)
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
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: recipeCellIdentifier, for: indexPath) as? RecipeCollectionViewCell else {
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

extension MixRecipeViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    var width: CGFloat = 0.0
    var height: CGFloat = 0.0
    
    if recipeMode == .SingleMode {
      width = ScreenWidth - MarginLeftInSingle - MarginRightInSingle
      height = HeightInSingle
    }
    else if recipeMode == .MultipleMode {
      width = (ScreenWidth - MarginLeftInSingle * MarginRightInSingle - SpacingItemInMultiple) / 2.0
      height = HeightInMultiple
    }
    
    return CGSize(width: width, height: height)
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
