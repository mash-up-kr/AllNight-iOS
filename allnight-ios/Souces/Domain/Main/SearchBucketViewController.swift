//
//  SearchBucketViewController.swift
//  allnight-ios
//
//  Created by 공지원 on 19/08/2019.
//  Copyright © 2019 kanghoon. All rights reserved.
//

import UIKit

class SearchBucketViewController: UIViewController {
    
    //MARK: - Property
    
    //MAKR: - IBOutlet
    @IBOutlet var tableView: UITableView!
    
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
    
    //MARK: - Method
    func handleRemoveButton(cell: SearchBucketTableViewCell) {
        //view 변경 - 셀 삭제
        
        if let indexPath = tableView.indexPath(for: cell) {
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

//MARK: - TableView Data Source
extension SearchBucketViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BucketManager.shared.ingredientsInBucket.count
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
