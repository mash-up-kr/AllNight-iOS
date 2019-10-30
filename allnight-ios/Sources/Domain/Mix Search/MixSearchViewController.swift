//
//  MixSearchViewController.swift
//  allnight-ios
//
//  Created by ohkanghoon on 29/06/2019.
//  Copyright © 2019 kanghoon. All rights reserved.
//

import UIKit

final class MixSearchViewController: UIViewController {
    
    @IBOutlet weak var searchResultTableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    
    private var searchResult: Array<String> = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTextField.attributedPlaceholder = NSAttributedString(string: "ex) 보드카".localized, attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)])
        initTableView()
    }
    
    private func initTableView() {
        searchResultTableView.dataSource = self
        searchResultTableView.delegate = self
    }
    
    @IBAction func onSearchTextChanged(_ sender: UITextField) {
        let inputText = sender.text!
        
        searchResult.removeAll()
        if !inputText.isEmpty {
            for i in 0...(arc4random_uniform(5) + 2) {
                searchResult.append(sender.text! + String(i))
            }
        }
        searchResultTableView.reloadData()
    }
    
}

//MARK: - Table View Data Source
extension MixSearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell") as? SearchResultTableViewCell else { return UITableViewCell() }
        
        cell.configure(text: searchResult[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.searchResult.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        showToast(message: "추가되었습니다.".localized)
    }
    
    private func showToast(message: String) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
}

//MARK: - Table View Delegate
extension MixSearchViewController: UITableViewDelegate {
    
}
