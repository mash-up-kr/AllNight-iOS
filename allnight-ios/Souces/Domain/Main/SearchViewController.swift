//
//  SearchViewController.swift
//  allnight-ios
//
//  Created by 공지원 on 16/08/2019.
//  Copyright © 2019 kanghoon. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var ingredientQuestionLabel: UILabel!
    @IBOutlet weak var detailInstructionLabel: UILabel!
    //MARK: - Property
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private var searchResults: [String] = []
    private let cellIdentifier = "searchTableViewCell"
    
    //MARK: - IBOutlet
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var tableView: UITableView!

    //MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        ingredientQuestionLabel.text = "어떤 술/재료로 만드시나요?".localized
        detailInstructionLabel.text = "여러개를 선택하실 수 있습니다.".localized
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
        searchTextField.attributedPlaceholder = NSAttributedString(string: "ex) 보드카".localized, attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        
        //searchTextField clear버튼 설정
        guard let clearButton = searchTextField.value(forKey: "_clearButton") as? UIButton else {
            print("clearButton is nil.")
            return
        }
        
        clearButton.setImage(UIImage(named: "icSmallx24Normal"), for: .normal)
    }
    
    //서버 통신
    private func getIngredientList(ingredient: String) {
            AllNightProvider.search(ingredient: ingredient, completion: {[weak self] in
                guard let self = `self` else { return }
                
                if let data = try? $0.decodeJSON([String].self).get() {
                    self.searchResults = data
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }) {
                print($0.errorDescription ?? "no errorDescription!")
            }
    }
}

//MARK: - TableView Data Source
extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? SearchTableViewCell else { return SearchTableViewCell() }
        
        cell.configure(ingredient: searchResults[indexPath.row])
        
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
