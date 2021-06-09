//
//  WriteNewStockTypeView.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/05/19.
//

import UIKit

class WriteNewStockTypeView: BaseView {
    
    let titleLabel = UILabel().then {
        $0.font = .body1_16
        $0.textColor = .sub_white_w1
        $0.text = "write_new_stock_type_title".localized
    }
    
    let closeButton = UIButton().then {
        $0.setImage(.close24, for: .normal)
    }
    
    let descriptionLabel = UILabel().then {
        $0.font = .subtitle1_24
        $0.textColor = .sub_white_w1
        $0.numberOfLines = 0
        $0.text = "write_new_stock_type_description".localized
    }
    
    let stockTypeRadioGroupView = StockTypeRadioGroupView()
    
    let stockNameLabel = UILabel().then {
        $0.font = .caption1_12R
        $0.textColor = .sub_white_w3
        $0.text = "write_new_stock_type_name".localized
    }
    
    let stockSearchButton = StockSearchButton()
    
    let warningLabel = UILabel().then {
        $0.font = .body2_14R
        $0.textColor = .sub_black_b5
        $0.text = "- 가상화페 항목은\n업비트거래소를 기준으로 검색 가능합니다."
        $0.numberOfLines = 0
    }
    
    override func setup() {
        self.backgroundColor = .sub_black_b1
        self.addSubviews(
            titleLabel, closeButton, descriptionLabel, stockTypeRadioGroupView,
            stockNameLabel, stockSearchButton, warningLabel
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
        
        self.descriptionLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(self.titleLabel.snp.bottom).offset(33)
        }
        
        self.stockTypeRadioGroupView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.descriptionLabel.snp.bottom).offset(24)
        }
        
        self.stockNameLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(24)
            make.top.equalTo(self.stockTypeRadioGroupView.snp.bottom).offset(40)
        }
        
        self.stockSearchButton.snp.makeConstraints { make in
            make.top.equalTo(stockNameLabel.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
        }
        
        self.warningLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(self.stockSearchButton.snp.bottom).offset(32)
        }
    }
}
