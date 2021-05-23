//
//  SearchStockView.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/05/21.
//

import UIKit
import RxSwift

class SearchStockView: BaseView {
    
    let titleLabel = UILabel().then {
        $0.font = .body1_16
        $0.textColor = .sub_white_w1
        $0.text = "search_stock_title".localized
    }
    
    let closeButton = UIButton().then {
        $0.setImage(.close24, for: .normal)
    }
    
    let searchStockField = SearchStockField()
    
    let historyTableView = SearchHistoryTableView()
    
    let stockTableView = UITableView().then {
        $0.backgroundColor = .clear
        $0.tableFooterView = UIView()
        $0.separatorStyle = .none
        $0.contentInset = .init(top: 10, left: 0, bottom: 10, right: 0)
        $0.register(SearchCell.self, forCellReuseIdentifier: SearchCell.reusableIdentifier)
    }
    
    
    override func setup() {
        self.backgroundColor = .sub_black_b2
        self.addSubviews(
            titleLabel, closeButton, searchStockField, historyTableView,
            stockTableView
        )
        
        self.searchStockField.rx.text.orEmpty
            .map { $0.isEmpty }
            .asDriver(onErrorJustReturn: false)
            .drive { [weak self] isEmpty in
                self?.historyTableView.isHidden = !isEmpty
                self?.stockTableView.isHidden = isEmpty
            }
            .disposed(by: self.disposeBag)
    }
    
    override func bindConstraints() {
        self.titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.safeAreaLayoutGuide).offset(11)
        }
        
        self.closeButton.snp.makeConstraints { make in
            make.centerY.equalTo(self.titleLabel)
            make.right.equalToSuperview().offset(-20)
        }
        
        self.searchStockField.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(33)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        
        self.historyTableView.snp.makeConstraints { make in
            make.top.equalTo(self.searchStockField.snp.bottom).offset(32)
            make.left.right.bottom.equalToSuperview()
        }
        
        self.stockTableView.snp.makeConstraints { make in
            make.top.equalTo(self.searchStockField.snp.bottom).offset(32)
            make.left.right.bottom.equalToSuperview()
        }
    }
}
