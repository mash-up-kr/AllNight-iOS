//
//  SearchBucketViewController.swift
//  allnight-ios
//
//  Created by 공지원 on 19/08/2019.
//  Copyright © 2019 kanghoon. All rights reserved.
//

//버킷에 담은 재료가 하나도 없다면, searchRecipeButton 비활성화 해줘야할듯

import UIKit

class SearchBucketViewController: UIViewController {
    
    //MARK: - Property
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MAKR: - IBOutlet
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchRecipeButton: UIButton!
    
    //MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    }
    
    //MARK: - IBAction
    @IBAction func backButtonDidTap(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func searchRecipeButtonDidTap(_ sender: UIButton) {
        //재료가 들어간 레시피 리스트 보여주는 화면으로 연결
        let storyboard = UIStoryboard(name: "MixRecipe", bundle: nil)
        let nextViewController = storyboard.instantiateViewController(withIdentifier: "mixRecipeView") as! MixRecipeViewController
        present(nextViewController, animated: true, completion: nil)
    }
    
    //MARK: - Method
    func handleRemoveButton(cell: SearchBucketTableViewCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

//MARK: - TableView Data Source
extension SearchBucketViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
  
        return CocktailManager.shared.ingredientsInBucket.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "bucketCell", for: indexPath) as? SearchBucketTableViewCell else { return UITableViewCell() }
        cell.configure(indexPath: indexPath)
        cell.delegate = self
        
        return cell
    }
}

//MARK: - TableView Delegate
extension SearchBucketViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
}
