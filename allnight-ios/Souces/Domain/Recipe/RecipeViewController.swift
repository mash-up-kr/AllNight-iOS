//
//  RecipeViewController.swift
//  allnight-ios
//
//  Created by ohkanghoon on 29/06/2019.
//  Copyright © 2019 kanghoon. All rights reserved.
//

import UIKit

enum RecipeTableCell: String, CaseIterable {
    case need
    case information
}

final class RecipeViewController: UIViewController {
    @IBOutlet weak var headerHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    
    let minHeaderHeight: CGFloat = 141
    let maxHeaderHeight: CGFloat = 276
    
    var previousScrollOffset: CGFloat = 0
    var isAnimating = false
    
    // MARK: View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        headerHeightConstraint.constant = maxHeaderHeight
        expandHeader()
    }
    
    private func initTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset.top = maxHeaderHeight
    }
}

// MARK: UITableViewDataSource
extension RecipeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return 5
        }
        else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell()
//        cell.textLabel?.text = "Article \(indexPath.row)"
//        let cell: UITableViewCell
        
        switch indexPath.section {
        case 1:
            let lastRowIndex = tableView.numberOfRows(inSection: indexPath.section) - 1
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeHeaderTableViewCell", for: indexPath)
                cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
                return cell
            } else if indexPath.row == lastRowIndex {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeRowTableViewCell", for: indexPath) as? RecipeRowTableViewCell else {
                    return UITableViewCell()
                }
                cell.changeBottomConstraint()
                return cell
            } else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeRowTableViewCell", for: indexPath) as? RecipeRowTableViewCell else {
                    return UITableViewCell()
                }
                cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
                return cell
            }
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "DetailInformationTableViewCell", for: indexPath) as? DetailInformationTableViewCell else {
                return UITableViewCell()
            }
            return cell
        }
    }
}

// MARK: UITableViewDelegate
extension RecipeViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard !isAnimating else { return }
        
        let scrollDiff = scrollView.contentOffset.y - previousScrollOffset
        
        let absoluteTop: CGFloat = 0
        
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
        print(scrollViewMaxHeight)
        print(scrollView.contentSize.height)
    
        // header가 줄어들었을 때, 스크롤 할 수 있는 공간 여전히 만들어 두기
        // 여기 공간 부분 cell이 4개일때에도 되도록 계산하기!
        return scrollView.contentSize.height > scrollViewMaxHeight
    }
    
    func expandHeader() {
        self.view.layoutIfNeeded()
        self.isAnimating = true
        UIView.animate(withDuration: 0.2, animations: {
            self.headerHeightConstraint.constant = self.maxHeaderHeight
            self.view.layoutIfNeeded()
        }) { _ in
            self.isAnimating = false
        }
    }
}
