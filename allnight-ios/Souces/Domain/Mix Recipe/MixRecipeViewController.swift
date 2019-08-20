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
  
  var recipeMode: MixRecipeMode = .SingleMode
  
  @IBAction func tapHome(_ sender: Any) {
    
  }
  
  @IBAction func tapFilter(_ sender: Any) {
    
  }
  
  @IBAction func tapMode(_ sender: Any) {
    if recipeMode == .SingleMode {
      recipeMode = .MultipleMode
    }
    else if recipeMode == .MultipleMode {
      recipeMode = .SingleMode
    }
    
    recipeCollectionView.setCollectionViewLayout(createCollectionViewLayout(recipeMode: recipeMode), animated: false)
  }
  
  func createCollectionViewLayout(recipeMode: MixRecipeMode) -> UICollectionViewFlowLayout {
    let layout = UICollectionViewFlowLayout()
    
    if recipeMode == .SingleMode {
      layout.sectionInset = UIEdgeInsets(top: 0.0, left: 16.0, bottom: 0.0, right: 16.0)
      layout.minimumLineSpacing = 32.0
      layout.minimumInteritemSpacing = 0.0
    }
    else if recipeMode == .MultipleMode {
      layout.sectionInset = UIEdgeInsets(top: 31.0, left: 16.0, bottom: 0.0, right: 16.0)
      layout.minimumLineSpacing = 24.0
      layout.minimumInteritemSpacing = 0.0
    }
    
    return layout
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
    
    recipeCollectionView.setCollectionViewLayout(createCollectionViewLayout(recipeMode: recipeMode), animated: false)
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

extension MixRecipeViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    var width = 0.0
    var height = 0.0
    
    if recipeMode == .SingleMode {
      width = 343.0
      height = 480.0
    }
    else if recipeMode == .MultipleMode {
      width = 164.0
      height = 209.9
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
