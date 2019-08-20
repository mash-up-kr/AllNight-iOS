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
    
    private var searchResults: [String] = []
    
    //MARK: - IBOutlet
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var tableView: UITableView!

    //MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commonInit()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }

    //MARK: - IBAction
    @IBAction func findButtonDidTap(_ sender: UIButton) {
        guard let ingredient = searchTextField.text else { return }
        getIngredientList(ingredient: ingredient)
    }
    
    @IBAction func backButtonDidTap(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Method
    private func commonInit() {
        //data source, delegate 설정
        searchTextField.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        //change searchTextField placeholder color
        searchTextField.attributedPlaceholder = NSAttributedString(string: "ex)칵테일", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        
        //searchTextField clear버튼 설정
        guard let clearButton = searchTextField.value(forKey: "_clearButton") as? UIButton else {
            print("clearButton is nil.")
            return
        }
        
        clearButton.setImage(UIImage(named: "icSmallx24Normal"), for: .normal)
    }
    
    //서버 통신
    func getIngredientList(ingredient: String) {
            AllNightProvider.search(ingredient: ingredient, completion: {[weak self] in
                guard let self = `self` else { return }
                
                if let data = try? $0.decodeJSON([String].self).get() {
                    self.searchResults = data
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }) {
                print($0.errorDescription ?? "")
            }
    }
}

//MARK: - TableView Data Source
extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //FIXME: - 네트워킹 필요
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "searchTableViewCell", for: indexPath) as? SearchTableViewCell else { return SearchTableViewCell() }
        
        cell.configure(result: searchResults[indexPath.row])
        
        return cell
    }
}

//MARK: - TableView Delegate
extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
}

//MARK: - TextField Delegate
extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        guard let ingredient = searchTextField.text else { return false }
        getIngredientList(ingredient: ingredient)
        
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        searchResults = []
        tableView.reloadData()
        return true
    }
}
