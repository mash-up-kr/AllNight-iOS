//
//  MainViewController.swift
//  allnight-ios
//
//  Created by ohkanghoon on 29/06/2019.
//  Copyright © 2019 kanghoon. All rights reserved.
//

/*
 - 칵테일 이름 폰트 변경
 - 플로팅 버튼 안먹힘
 - scrap 기능
 */
import UIKit

final class MainViewController: UIViewController {
    
    //MARK: - Property
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private let transition = SlideInTransition()
    private let cellIdentifier = "recipeCollectionViewCell"
    
    //MARK: - IBOutlet
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var floatingButton: UIButton!
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.layer.addSublayer(floatingButton.layer)
        
        setUpCollectionView()
    }
    
    //MARK: - Method
    private func setUpCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        
        //add header view
        collectionView.register(UINib(nibName: "MainCollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Header")
    }
    
    //MARK: - IBAction
    @IBAction func menuBarButtonDidTap(_ sender: UIButton) {
        print("menuBarButtonDidTap")

        //TODO: - show side menu bar
        guard let sideMenuViewController = storyboard?.instantiateViewController(withIdentifier: "SideMenuViewController") else { return }

        sideMenuViewController.modalPresentationStyle = .overCurrentContext
        //side Menu VC의 화면 전환에 대한 처리는 내가(MainViewController)가 하겠다는 의미
        sideMenuViewController.transitioningDelegate = self
        present(sideMenuViewController, animated: true, completion: nil)
    }

    @IBAction func floatingButtonDidTap(_ sender: UIButton) {
        print("floatingButtonDidTap")
    }
    
}

//MARK: - Collection View Data Source
extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? MainCollectionViewCell else { return UICollectionViewCell() }
        
        cell.configure(indexPath: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    //section header view
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerView", for: indexPath)
        
        return headerView
    }
}

//MARK: - Collection View Delegate
extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("didSelectItemAt: \(indexPath)")
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
