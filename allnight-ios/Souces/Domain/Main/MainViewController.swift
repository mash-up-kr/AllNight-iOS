//
//  MainViewController.swift
//  allnight-ios
//
//  Created by ohkanghoon on 29/06/2019.
//  Copyright © 2019 kanghoon. All rights reserved.
//

import UIKit
import Moya

final class MainViewController: UIViewController {
    
    //MARK: - Property
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private var cocktails: [Cocktail] = []
    private var favorites: Set<String> = []
    
    private let transition = SlideInTransition()
    private let cellIdentifier = "recipeCollectionViewCell"
    
    //MARK: - IBOutlet
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var floatingButton: UIButton!
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpCollectionView()
    
        //서버로부터 칵테일 리스트 받아옴
        AllNightProvider.searchStaticCocktails(completion: {
            if let data = try? $0.decodeJSON([Cocktail].self).get() {
                self.cocktails = data
                self.collectionView.reloadData()
            }
        }) {
            print($0.errorDescription ?? "")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        collectionView.reloadData()
    }
    
    //MARK: - Method
    private func setUpCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        
    }
    
    func handleScrapButtonDidTap(cell: MainCollectionViewCell) {
        guard let indexPathTapped = collectionView.indexPath(for: cell) else {
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
    
    func handleMenuBarButtonDidTap() {
        guard let sideMenuViewController = storyboard?.instantiateViewController(withIdentifier: "SideMenuViewController") else { return }
        
        sideMenuViewController.modalPresentationStyle = .overCurrentContext
        sideMenuViewController.transitioningDelegate = self
        present(sideMenuViewController, animated: true, completion: nil)
    }
    
    func handleScrappedRecipeDidTap() {
        let mixRecipeStoryboard = UIStoryboard(name: "MixRecipe", bundle: nil)
        
        guard let dest = mixRecipeStoryboard.instantiateViewController(withIdentifier: "mixRecipeView") as? MixRecipeViewController else {
            print("MixRecipeViewController is nil")
            return
        }
        
        dest.editMode = .scrapMode
        
        present(dest, animated: true, completion: nil)
    }
}

//MARK: - Collection View Data Source
extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? MainCollectionViewCell else { return UICollectionViewCell() }
        
        cell.delegate = self
        cell.configure(indexPath: indexPath, cocktailInfo: cocktails[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cocktails.count
    }
    
    //section header view
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerView", for: indexPath) as? MainCollectionReusableHeaderView else {
            print("headerView is nil")
            return UICollectionReusableView()
        }
        
        headerView.delegate = self
        
        return headerView
    }
}

//MARK: - Collection View Delegate
extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("didSelectItemAt: \(indexPath)")
        
        
        let recipeStoryboard = UIStoryboard(name: "Recipe", bundle: nil)
        
        guard let dest = recipeStoryboard.instantiateViewController(withIdentifier: "RecipeViewController") as? RecipeViewController else {
            print("RecipeViewController is nil")
            return
        }
        
        let id = cocktails[indexPath.row].id
        print("RecipeVC에 넘겨주는 id: \(id)")
        dest.searchDetailRecipe(id: id)
        present(dest, animated: true, completion: nil)
    }
}

//MARK: - Side Menu View Controller Transition Delegate
extension MainViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = true
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = false
        return transition
    }
}

