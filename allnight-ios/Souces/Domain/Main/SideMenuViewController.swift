//
//  SideMenuViewController.swift
//  allnight-ios
//
//  Created by 공지원 on 12/07/2019.
//  Copyright © 2019 kanghoon. All rights reserved.
//

import UIKit

class SideMenuViewController: UIViewController {
    
    //MARK: - Property
    private let firstCellIdentifier = "scrapRecipeCell"
    private let secondCellIdentifier = "recentRecipeCell"
    
    //MARK: - IBOutlet
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpTableView()
    }

    private func setUpTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.contentInset = UIEdgeInsets(top: 203, left: 0, bottom: 0, right: 0)
    }
    
    //MARK: - IBAction
    @IBAction func cancelButtonDidTap(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

extension SideMenuViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var identifier = ""
        
        if indexPath.row == 0 {
            identifier = firstCellIdentifier
        }
        else if indexPath.row == 1 {
            identifier = secondCellIdentifier
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? SideMenuTableViewCell else { return UITableViewCell() }
        
        cell.configure(indexPath: indexPath)
        
        return cell
    }
}

extension SideMenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            //TODO: - 스크랩 모아보기 화면으로 이동
          let storyboard = UIStoryboard(name: "MixRecipe", bundle: nil)
          let nextViewController = storyboard.instantiateViewController(withIdentifier: "mixRecipeView") as! MixRecipeViewController
          
          nextViewController.editMode = .scrapMode
          present(nextViewController, animated: true, completion: nil)
        }
        else if indexPath.row == 1 {
          let storyboard = UIStoryboard(name: "MixRecipe", bundle: nil)
          let nextViewController = storyboard.instantiateViewController(withIdentifier: "mixRecipeView") as! MixRecipeViewController
          
          nextViewController.editMode = .recentMode
          present(nextViewController, animated: true, completion: nil)
        }
      
      tableView.deselectRow(at: indexPath, animated: true)
    }
}
