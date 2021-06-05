//
//  StockDetailChildView.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/06/05.
//

import UIKit

class StockDetailChildView: BaseView {
    
    let tableView = UITableView().then {
        $0.estimatedRowHeight = UITableView.automaticDimension
        $0.tableFooterView = UIView()
        $0.separatorStyle = .none
        $0.backgroundColor = .sub_black_b2
        $0.showsVerticalScrollIndicator = false
        $0.register(
            StockDetailOverviewCell.self,
            forCellReuseIdentifier: StockDetailOverviewCell.registerId
        )
        $0.register(
            StockDetailItemCell.self,
            forCellReuseIdentifier: StockDetailItemCell.registerId
        )
    }
    
    
    override func setup() {
        self.addSubview(tableView)
    }
    
    override func bindConstraints() {
        self.tableView.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
    }
}
