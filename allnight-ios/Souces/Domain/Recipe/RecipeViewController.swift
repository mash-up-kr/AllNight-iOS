//
//  RecipeViewController.swift
//  allnight-ios
//
//  Created by ohkanghoon on 29/06/2019.
//  Copyright © 2019 kanghoon. All rights reserved.
//

import UIKit

enum RecipeTableCell: String, CaseIterable {
    case RecipeHeaderTableViewCell
    case RecipeRowTableViewCell
    case DetailInformationTableViewCell
}

final class RecipeViewController: UIViewController {
    @IBOutlet weak var headerHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerImageView: UIImageView!
    
    let minHeaderHeight: CGFloat = 141
    let maxHeaderHeight: CGFloat = 276
    
    let animationDuration: TimeInterval = 0.2
    let absoluteTop: CGFloat = 0
    
    var previousScrollOffset: CGFloat = 0
    var isAnimating = false
    
    // MARK: View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
    }
    
    private func initTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset.top = maxHeaderHeight
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        headerHeightConstraint.constant = maxHeaderHeight
        expandHeader()
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: private functions for tableviewcell
private extension RecipeViewController {
    func getRecipeHeaderTableViewCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath, reusableCellIdentifier: String) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reusableCellIdentifier, for: indexPath)
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
        return cell
    }
    
    func getRecipeRowTableViewCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath, reusableCellIdentifier: String) -> UITableViewCell {
        let lastRowIndex = tableView.numberOfRows(inSection: indexPath.section) - 1
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reusableCellIdentifier, for: indexPath) as? RecipeRowTableViewCell else {
            return UITableViewCell()
        }

        if indexPath.row == lastRowIndex {
            cell.changeBottomConstraint(constraint: 32)
            cell.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        } else {
            cell.changeBottomConstraint(constraint: 8)
            cell.separatorInset = UIEdgeInsets(top: 0, left: 10000, bottom: 0, right: 0)
        }
        
        return cell
    }
    
    func getDetailInformationTableViewCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath, reusableCellIdentifier: String) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reusableCellIdentifier, for: indexPath) as? DetailInformationTableViewCell else {
            return UITableViewCell()
        }
        
        switch indexPath.section {
        case 0:
            cell.configure(title: "INTRO", detail: "칵테일이라는 이름의 유래는 여러가지 설이 있으나, 17 95년에 미국의 루이지애나주 뉴올리언스에 이주해온A. A. 페이쇼라는 약사가 달걀 노른자를 넣은 음료를 조합하여 프랑스어로 코크티에(coquetier)라고 부른 데에서 비롯되었다는 설이 가장 유력합니다.")
        case 1:
            cell.configure(title: "GLASS", detail: "Glass")
        default:
            cell.configure(title: "INSTRUCTION", detail: "18oz 맥주 유리에 코로나를 부어 맥주에 럼주를 부어 넣으십시오.")
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
        }
        
        return cell
    }
}

// MARK: UITableViewDataSource
extension RecipeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 2 {
            return 5
        }
        else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        
        switch indexPath.section {
        case 2:
            if indexPath.row == 0 {
                cell = getRecipeHeaderTableViewCell(tableView, cellForRowAt: indexPath, reusableCellIdentifier: RecipeTableCell.RecipeHeaderTableViewCell.rawValue)
            } else {
                cell = getRecipeRowTableViewCell(tableView, cellForRowAt: indexPath, reusableCellIdentifier: RecipeTableCell.RecipeRowTableViewCell.rawValue)
            }
        default:
            cell = getDetailInformationTableViewCell(tableView, cellForRowAt: indexPath, reusableCellIdentifier: RecipeTableCell.DetailInformationTableViewCell.rawValue)
        }
        
        return cell
    }
}

// MARK: UITableViewDelegate
extension RecipeViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard !isAnimating else { return }
        
        let scrollDiff = scrollView.contentOffset.y - previousScrollOffset
        
        let isScrollingUp = scrollDiff > 0 && scrollView.contentOffset.y + scrollView.contentInset.top > absoluteTop
        let isScrollingDown = scrollDiff < 0 && scrollView.contentOffset.y < -minHeaderHeight
        
        if canAnimateHeader(scrollView) {
            
            // 새로운 높이 계산
            var newHeight = headerHeightConstraint.constant
            
            if scrollView.contentOffset.y + scrollView.contentInset.top > 0 {
                // tableview가 제일 상단이 아닐때,
                if isScrollingUp {
                    newHeight = max(minHeaderHeight, headerHeightConstraint.constant - abs(scrollDiff))
                } else if isScrollingDown {
                    newHeight = min(maxHeaderHeight, headerHeightConstraint.constant + abs(scrollDiff))
                }
            } else {
                // 제일 상단일 때, 높이 설정
                newHeight = maxHeaderHeight
            }
            
            // header 높이 설정
            if newHeight != headerHeightConstraint.constant {
                headerHeightConstraint.constant = newHeight
            }
            
            previousScrollOffset = scrollView.contentOffset.y
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollViewDidStopScrolling()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            scrollViewDidStopScrolling()
        }
    }
    
    func scrollViewDidStopScrolling() {
        let diff = tableView.contentOffset.y + headerHeightConstraint.constant
        
        if diff < 0 {
            expandHeader()
        }
    }
    
    func canAnimateHeader(_ scrollView: UIScrollView) -> Bool {
        // header가 줄어들었을 때, scrollView의 사이즈 계산
        let scrollViewMaxHeight = scrollView.frame.height + headerHeightConstraint.constant - (minHeaderHeight + 100)
    
        // header가 줄어들었을 때, 스크롤 할 수 있는 공간 여전히 만들어 두기
        return scrollView.contentSize.height > scrollViewMaxHeight
    }
    
    func expandHeader() {
        self.view.layoutIfNeeded()
        self.isAnimating = true
        UIView.animate(withDuration: animationDuration, animations: {
            self.headerHeightConstraint.constant = self.maxHeaderHeight
            self.view.layoutIfNeeded()
        }) { _ in
            self.isAnimating = false
        }
    }
}
