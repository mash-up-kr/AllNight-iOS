//
//  SearchViewController.swift
//  allnight-ios
//
//  Created by 공지원 on 16/08/2019.
//  Copyright © 2019 kanghoon. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    //MARK: - Property
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: - IBOutlet
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        searchTextField.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        //change search textField placeholder color
        searchTextField.attributedPlaceholder = NSAttributedString(string: "ex)칵테일", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        
        guard let clearButton = searchTextField.value(forKey: "_clearButton") as? UIButton else {
            print("clearButton is nil.")
            return
        }

        clearButton.setImage(UIImage(named: "icSmallx24Normal"), for: .normal)
    }

    //MARK: - IBAction
    @IBAction func findButtonDidTap(_ sender: UIButton) {
        print("findButtonDidTap")
        //TODO: - 검색 결과 테이블에 보여줌
    }
    
    @IBAction func backButtonDidTap(_ sender: UIButton) {
        print("backButtonDidTap")
        
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Method
    func handlePutInCartButton() {
        print("handlePutInCartButton")
    }
}

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("textFieldShouldReturn")
        
        textField.resignFirstResponder()
        
        return true
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //FIXME: - 네트워킹 필요
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "searchTableViewCell", for: indexPath) as? SearchTableViewCell else { return SearchTableViewCell() }
        
        cell.delegate = self
        
        return cell
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
}
