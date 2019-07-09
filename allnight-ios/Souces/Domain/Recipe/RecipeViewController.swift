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
    
    let minHeaderHeight: CGFloat = 176
    let maxHeaderHeight: CGFloat = 343
    
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "Article \(indexPath.row)"
        return cell
    }
}

// MARK: UITableViewDelegate
extension RecipeViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard !isAnimating else { return }
        
        if scrollView.contentOffset.y == -387.0 {
            scrollView.contentOffset.y = -maxHeaderHeight
        }
        
        let scrollDiff = scrollView.contentOffset.y - previousScrollOffset
        
        let absoluteTop: CGFloat = 0
        
        let isScrollingUp = scrollDiff > 0 && scrollView.contentOffset.y + scrollView.contentInset.top > absoluteTop
        let isScrollingDown = scrollDiff < 0 && scrollView.contentOffset.y < -minHeaderHeight
        
        if canAnimateHeader(scrollView) {
            
            // 새로운 높이 계산
            var newHeight = headerHeightConstraint.constant
            
            print(abs(scrollDiff))
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
                print(headerHeightConstraint.constant)
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
        let scrollViewMaxHeight = scrollView.frame.height + headerHeightConstraint.constant - minHeaderHeight
    
        // header가 줄어들었을 때, 스크롤 할 수 있는 공간 여전히 역만들어 두기
        return scrollView.contentSize.height > scrollViewMaxHeight
    }
    
    func expandHeader() {
        self.view.layoutIfNeeded()
        let diff = maxHeaderHeight - headerHeightConstraint.constant
        self.isAnimating = true
        UIView.animate(withDuration: 0.2, animations: {
            self.headerHeightConstraint.constant = self.maxHeaderHeight
            self.view.layoutIfNeeded()
        }) { _ in
            self.isAnimating = false
        }
    }
}
