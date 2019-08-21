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
    
    //서버로부터 칵테일 리스트 받아와 배열에 저장
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
                //print(self.cocktails)
                //print("cocktails.count: \(self.cocktails.count)")
                self.collectionView.reloadData()
            }
        }) {
            print($0.errorDescription ?? "")
        }
    }
    
    //MARK: - Method
    private func setUpCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        
    }
    
    func handleScrapButtonDidTap(cell: MainCollectionViewCell) {
        //몇번째 셀이 눌린건지 확인
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
        print("handleMenuBarButtonDidTap")
        
        //TODO: - show side menu bar
        guard let sideMenuViewController = storyboard?.instantiateViewController(withIdentifier: "SideMenuViewController") else { return }
        
        sideMenuViewController.modalPresentationStyle = .overCurrentContext
        sideMenuViewController.transitioningDelegate = self
        present(sideMenuViewController, animated: true, completion: nil)
    }
    
    //MARK: - IBAction
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
        //TODO: - 선택한 칵테일에 대한 detail recipe 화면으로 연결 
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

