//
//  RecipeViewController.swift
//  allnight-ios
//
//  Created by ohkanghoon on 29/06/2019.
//  Copyright © 2019 kanghoon. All rights reserved.
//

import UIKit
import Kingfisher

enum RecipeTableCell: String, CaseIterable {
    case RecipeHeaderTableViewCell
    case RecipeRowTableViewCell
    case DetailInformationTableViewCell
}

final class RecipeViewController: UIViewController {
    @IBOutlet weak var headerHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var drinkNameLabel: UILabel!
    @IBOutlet weak var scrapButton: UIButton!
    
    let minHeaderHeight: CGFloat = 141
    let maxHeaderHeight: CGFloat = 276
    
    let animationDuration: TimeInterval = 0.2
    let absoluteTop: CGFloat = 0
    
    var previousScrollOffset: CGFloat = 0
    var isAnimating = false
    
    // 서버로부터 받은 정보 저장 변수
    var cocktailDetail: CocktailDetail?
    var cocktailId: String = ""
    
    //MARK: Property
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
//        searchDetailRecipe(id: "AWwR4K0EVDB3vSw6z8CM")
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
    
    @IBAction func scrapButtonAction(_ sender: Any) {
        if scrapButton.isSelected { // 스크랩을 벌써 한 상태 -> 스크랩 해제
            CocktailManager.shared.scrappedCocktails.remove(cocktailId)
        } else {
            CocktailManager.shared.scrappedCocktails.insert(cocktailId)
        }
        scrapButton.isSelected = !scrapButton.isSelected
    }
}

// MARK: private functions for headerView
private extension RecipeViewController {
    func updateDetailHeaderView() {
        // 칵테일 썸네일 이미지 설정
        if let thumbnail = cocktailDetail?.drinkThumb {
            headerImageView.kf.setImage(with: thumbnail)
        }
        
        // 칵테일 이름 지정 (영어)
        if let drinkName = cocktailDetail?.enDrinkName {
            drinkNameLabel.text = drinkName
        }
        
        //스크랩 유무에 따른 아이콘 설정
        if CocktailManager.shared.scrappedCocktails.contains(cocktailId) {
            scrapButton.isSelected = true
        }
        else {
            scrapButton.isSelected = false
        }
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
        
        if let cocktail = cocktailDetail {
            var measurement = ""
            let ingredientName = LanguageManger.language == "ko" ? cocktail.ingredientArray[indexPath.row - 1] : cocktail.enIngredientArray[indexPath.row - 1]
            
            if indexPath.row <= cocktail.measureArray.count {
                if LanguageManger.language == "ko" {
                    measurement = cocktail.measureArray[indexPath.row - 1]
                } else {
                    measurement = cocktail.enMeasureArray[indexPath.row - 1]
                }
            }
            
            cell.configure(ingredientName: ingredientName , measure: measurement)
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
        var glass = ""
        var instruction = ""
        
        if LanguageManger.language == "ko" {
            glass = cocktailDetail?.glass ?? "잔에 대한 내용이 없습니다."
            instruction = cocktailDetail?.instructions ?? "Instruction에 대한 내용이 없습니다."
        } else {
            glass = cocktailDetail?.enGlass ?? "No information about glass."
            instruction = cocktailDetail?.enInstructions ?? "No information about instruction."
        }
        
        switch indexPath.section {
        case 0:
//            cell.configure(title: "INTRO", detail: "칵테일이라는 이름의 유래는 여러가지 설이 있으나, 17 95년에 미국의 루이지애나주 뉴올리언스에 이주해온A. A. 페이쇼라는 약사가 달걀 노른자를 넣은 음료를 조합하여 프랑스어로 코크티에(coquetier)라고 부른 데에서 비롯되었다는 설이 가장 유력합니다.")
//        case 1:
            cell.configure(title: "GLASS", detail: glass)
        default:
            cell.configure(title: "INSTRUCTION", detail: instruction)
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
        }
        
        return cell
    }
}

// MARK: UITableViewDataSource
extension RecipeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
//        return 4
        // INTRO 없는 버전
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if section == 2 {
        // INTRO 없는 버전
        if section == 1 {
            return (cocktailDetail?.ingredientArray.count ?? 0) + 1
        }
        else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        
        switch indexPath.section {
//        case 2:
        // INTRO 없는 버전
        case 1:
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
        view.layoutIfNeeded()
        isAnimating = true
        UIView.animate(withDuration: animationDuration, animations: {
            self.headerHeightConstraint.constant = self.maxHeaderHeight
            self.view.layoutIfNeeded()
        }) { _ in
            self.isAnimating = false
        }
    }
}

// MARK: Networking
extension RecipeViewController {
    func searchDetailRecipe(id: String) {
        AllNightProvider.searchCocktailDetail(id: id, completion: {
            if let data = try? $0.decodeJSON(CocktailDetail.self).get() {
                self.cocktailDetail = data
//                print(self.cocktailDetail ?? "")
                self.cocktailId = id
                DispatchQueue.main.async {
                    self.updateDetailHeaderView()
                    self.tableView.reloadData()
                }
            }
        }) {
            print($0.errorDescription ?? "")
        }
    }
}
