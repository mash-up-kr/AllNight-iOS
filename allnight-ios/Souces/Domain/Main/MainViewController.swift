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
    //var cocktails: [Cocktail] = []
    
    private let transition = SlideInTransition()
    private let cellIdentifier = "recipeCollectionViewCell"
    
    //private var RecipeNameArr: [String] = []
    
    //MARK: - IBOutlet
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var floatingButton: UIButton!
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpCollectionView()
    }
    
    //MARK: - Method
    private func setUpCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func handleScrapButtonDidTap(cell: MainCollectionViewCell) {
        print("handleScrapButtonDidTap")
        //스크랩 버튼 눌렀을때에 대한 처리 로직
        
        //몇번째 셀이 눌린건지 확인
        guard let indexPathTapped = collectionView.indexPath(for: cell), let cocktailNameTapped = cell.cocktailNameLabel.text else {
            return
        }
        
    //cell.isScrap 상태에 따라, 스크랩 컨테이너에 칵테일 이름을 추가했다 삭제했다 해야할듯

        print("indexPathTapped: \(indexPathTapped)")
        print("cocktailNameTapped: \(cocktailNameTapped)")
    }
    
    func handleMenuBarButtonDidTap() {
        print("handleMenuBarButtonDidTap")
        
        //TODO: - show side menu bar
        guard let sideMenuViewController = storyboard?.instantiateViewController(withIdentifier: "SideMenuViewController") else { return }
        
        sideMenuViewController.modalPresentationStyle = .overCurrentContext
        //side Menu VC의 화면 전환에 대한 처리는 내가(MainViewController)가 하겠다는 의미
        sideMenuViewController.transitioningDelegate = self
        present(sideMenuViewController, animated: true, completion: nil)
    }
    
    //MARK: - IBAction
    @IBAction func floatingButtonDidTap(_ sender: UIButton) {
        print("floatingButtonDidTap")
    }
}

//MARK: - Collection View Data Source
extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? MainCollectionViewCell else { return UICollectionViewCell() }
        
        cell.delegate = self
        cell.configure(indexPath: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    //section header view
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerView", for: indexPath) as? CollectionReusableView else {
            print("headerView is nil")
            return UICollectionReusableView()
        }
        
        headerView.link = self
        
        return headerView
    }
}

//MARK: - Collection View Delegate
extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("didSelectItemAt: \(indexPath)")
        //TODO: - 선택한 칵테일에 대한 상세 레시피 화면으로 이동
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

