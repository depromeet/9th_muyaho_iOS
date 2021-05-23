//
//  SearchHistoryTableView.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/05/23.
//

import UIKit
import RxSwift
import RxCocoa

class SearchHistoryTableView: BaseView {
    
    let historyLabel = UILabel().then {
        $0.font = .caption1_12R
        $0.textColor = .sub_white_w3
        $0.text = "search_stock_latest_history".localized
    }
    
    let shadowLine = UIView().then {
        $0.backgroundColor = .sub_black_b2
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.2
        $0.layer.shadowOffset = CGSize(width: 0, height: 4)
    }
    
    let historyTableView = UITableView().then {
        $0.backgroundColor = .clear
        $0.tableFooterView = UIView()
        $0.separatorStyle = .none
        $0.contentInset = .init(top: 10, left: 20, bottom: 10, right: 20)
        $0.register(SearchCell.self, forCellReuseIdentifier: SearchCell.reusableIdentifier)
    }
    
    
    override func setup() {
        self.backgroundColor = .clear
        self.addSubviews(historyLabel, shadowLine, historyTableView)
    }
    
    override func bindConstraints() {
        self.historyLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(24)
            make.top.equalToSuperview()
        }
        
        self.shadowLine.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.historyLabel.snp.bottom).offset(12)
            make.height.equalTo(2)
        }
        
        self.historyTableView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(self.shadowLine.snp.bottom)
        }
        
        self.snp.makeConstraints { make in
            make.top.equalTo(self.historyLabel).priority(.high)
            make.left.right.bottom.equalTo(self.historyTableView).priority(.high)
        }
    }
}

extension Reactive where Base: SearchHistoryTableView {
    
}
