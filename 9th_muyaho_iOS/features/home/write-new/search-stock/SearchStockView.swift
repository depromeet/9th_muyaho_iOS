//
//  SearchStockView.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/05/21.
//

import UIKit

class SearchStockView: BaseView {
    
    let titleLabel = UILabel().then {
        $0.font = .body1_16
        $0.textColor = .sub_white_w1
        $0.text = "stock_search_title".localized
    }
    
    let closeButton = UIButton().then {
        $0.setImage(.close24, for: .normal)
    }
    
    let searchStockField = SearchStockField()
    
    
    override func setup() {
        self.backgroundColor = .sub_black_b2
        self.addSubviews(
            titleLabel, closeButton, searchStockField
        )
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
    }
}
