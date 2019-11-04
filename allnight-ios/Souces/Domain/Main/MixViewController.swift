//
//  MixViewController.swift
//  allnight-ios
//
//  Created by 공지원 on 18/08/2019.
//  Copyright © 2019 kanghoon. All rights reserved.
//

import UIKit

class MixViewController: UIViewController {
    
    //MARK: - Property
    private let cellIdentifier = "inCartCell"
    var ingredientsInCart: [String] = []
    
    //MARK: - IBOutlet
    @IBOutlet var tableView: UITableView!

    //MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
    }
    
    //MARK: - IBAction
    @IBAction func backButtonDidTap(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

//MARK: - TableView Data Source
extension MixViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? InCartTableViewCell else { return UITableViewCell() }
        
        cell.configure(indexPath: indexPath)

        return cell
    }
}

//MARK: - TableView Delegate
extension MixViewController: UITableViewDelegate {
    
}
