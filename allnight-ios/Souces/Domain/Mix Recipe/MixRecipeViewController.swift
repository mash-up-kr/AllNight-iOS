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
  
  let filterPopupView = FilterPopupView()
  
  let ScreenWidth = UIScreen.main.bounds.width
  
  var recipeMode = MixRecipeMode.SingleMode
  
  var ingredients: [String] = CocktailManager.shared.getArrOfIngredientsInBucket()
  
  var cocktails: [Cocktail] = []
  
  var searchOffset = 0
  
  var isWating = false
  
  var ingredientCount = 3
  
  var isAlcohol = true
  
  private var didUpdateConstraints = false
  
  @IBAction func tapHome(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func tapFilter(_ sender: Any) {
    filterPopupView.isHidden.toggle()
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
  
  func doPaging() {
    DispatchQueue.main.async {
      AllNightProvider.searchCocktails(ingredients: self.ingredients, offset: self.searchOffset, isAlcohol: self.isAlcohol ? "true" : "false", ingredientCount: self.ingredientCount, completion: { [weak self] in
        guard let self = `self` else { return }
        
        if let data = try? $0.decodeJSON([Cocktail].self).get() {
          
          if data.count > 0 {
            self.cocktails.append(contentsOf: data)
            self.searchOffset += 1
            self.recipeCollectionView.reloadData()
          }
        }
        
        self.isWating = false
      }) {
        print($0.errorDescription ?? "" + " errorDescription!")
        
        self.isWating = false
      }
    }
  }
  
  // MARK: View LifeCycle

  override func viewDidLoad() {
    super.viewDidLoad()
    
    recipeCollectionView.delegate   = self
    recipeCollectionView.dataSource = self
    
    isWating = true
    doPaging()

    setModeImage(recipeMode: recipeMode)
    recipeCollectionView.setCollectionViewLayout(loadRecipeCollectionLayout(recipeMode: recipeMode), animated: true)
    
    filterPopupView.filterPopupDelegate = self
    filterPopupView.isHidden = true
    view.addSubview(filterPopupView)
    
    updateViewConstraints()
  }
  
  override func updateViewConstraints() {
    if !didUpdateConstraints {
      
      NSLayoutConstraint.activate([
        filterPopupView.leftAnchor.constraint(equalTo: view.leftAnchor),
        filterPopupView.rightAnchor.constraint(equalTo: view.rightAnchor),
        filterPopupView.topAnchor.constraint(equalTo: view.topAnchor),
        filterPopupView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
      ])
      
      didUpdateConstraints.toggle()
    }
    
    super.updateViewConstraints()
  }
}

// MARK: CollectionView LifeCycle

extension MixRecipeViewController: UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return cocktails.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: recipeCellIdentifier, for: indexPath) as? RecipeCollectionViewCell else {
      return UICollectionViewCell()
    }
    
    cell.cellDelegate = self
    cell.configure(indexPath: indexPath, cocktailInfo: cocktails[indexPath.row])
    
    return cell
  }
}

extension MixRecipeViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    if isWating {
      return
    }
    
    guard let recipeStoryboard = UIStoryboard(name: "Recipe", bundle: nil) as? UIStoryboard else {
      print("recipeStoryboard is nil")
      return
    }
    
    guard let dest = recipeStoryboard.instantiateViewController(withIdentifier: "RecipeViewController") as? RecipeViewController else {
      print("RecipeViewController is nil")
      return
    }
    
    let id = cocktails[indexPath.row].id
    dest.searchDetailRecipe(id: id)
    present(dest, animated: true, completion: nil)
  }
  
  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    if indexPath.row == cocktails.count - 1 && !isWating {
      isWating = true
      doPaging()
    }
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
      width = (ScreenWidth - MarginLeftInSingle - MarginRightInSingle - SpacingItemInMultiple) / 2.0
      height = HeightInMultiple
    }
    
    return CGSize(width: width, height: height)
  }
}

extension MixRecipeViewController: RecipeCollectionViewCellDelegate {
  func tapScrap(cell: RecipeCollectionViewCell) {
    guard let indexPathTapped = recipeCollectionView.indexPath(for: cell) else {
      return
    }
    
    let id = cocktails[indexPathTapped.row].id
    if cell.isScrap { //스크랩 한거면
      //스크랩 바구니에 칵테일 id를 추가
      CocktailManager.shared.scrappedCocktails.insert(id)
    } else { //스크랩 취소한거면
      //스크랩 바구니에서 칵테일 id 삭제
      CocktailManager.shared.scrappedCocktails.remove(id)
    }
  }
}

extension MixRecipeViewController: FilterPopupDelegate {
  func tapBackground() {
    filterPopupView.isHidden = true
  }
  
  func tapApply(alcoholIndex: Int, ingredientIndex: Int) {
    // 칵테일 서비스 재요청
    filterPopupView.isHidden = true
    
    print(alcoholIndex, ingredientIndex)
    
    if alcoholIndex == 1 {
      isAlcohol = false
    } else {
      isAlcohol = true
    }
    
    switch ingredientIndex {
    case 0:
      ingredientCount = 3
      break
    case 1:
      ingredientCount = 4
      break
    case 2:
      ingredientCount = 5
      break
    default:
      ingredientCount = 3
    }
    
    searchOffset = 0
    
    cocktails.removeAll()
    recipeCollectionView.reloadData()
    
    isWating = true
    doPaging()
  }
}
