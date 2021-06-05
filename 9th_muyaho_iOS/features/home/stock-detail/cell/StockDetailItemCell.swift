//
//  StockDetailItemCell.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/06/05.
//

import UIKit

class StockDetailItemCell: BaseTableViewCell {
    
    static let registerId = "\(StockDetailItemCell.self)"
    
    
    let stockContainerView = UIView().then {
        $0.layer.cornerRadius = 14
        $0.backgroundColor = .sub_black_b4
    }
    
    let titleLabel = UILabel().then {
        $0.font = .subtitle2_18
        $0.textColor = .sub_white_w1
        $0.text = "삼성전자"
    }
    
    let plLabel = UILabel().then {
        $0.font = .caption1_12R
        $0.textColor = .secondary_red_default
        $0.text = "668,434(11.8%)"
    }
    
    let plArrowImage = UIImageView().then {
        $0.image = .arrowUp
    }
    
    let priceLabel = UILabel().then {
        $0.font = .subtitle1_24
        $0.textColor = .sub_white_w1
        $0.text = "928,800"
    }
    
    let avgPriceLabel = UILabel().then {
        $0.font = .caption1_12R
        $0.textColor = .sub_white_w1
        $0.text = "common_average_price".localized
    }
    
    let avgPriceValueLabel = UILabel().then {
        $0.font = .body1_16
        $0.textColor = .sub_gray_20
        $0.text = "94,778"
    }
    
    let leftDividorView = UIView().then {
        $0.backgroundColor = UIColor(r: 150, g: 150, b: 150)
    }
    
    let currentPriceLabel = UILabel().then {
        $0.font = .caption1_12R
        $0.textColor = .sub_white_w1
        $0.text = "common_current_price".localized
    }
    
    let currentPriceValueLabel = UILabel().then {
        $0.font = .body1_16
        $0.textColor = .sub_gray_20
        $0.text = "83,600"
    }
    
    let rightDividorView = UIView().then {
        $0.backgroundColor = UIColor(r: 150, g: 150, b: 150)
    }
    
    let amountLabel = UILabel().then {
        $0.font = .caption1_12R
        $0.textColor = .sub_white_w1
        $0.text = "common_amount".localized
    }
    
    let amountValueLabel = UILabel().then {
        $0.font = .body1_16
        $0.textColor = .sub_gray_20
        $0.text = "8"
    }
    
    override func setup() {
        self.selectionStyle = .none
        self.backgroundColor = .sub_black_b2
        self.addSubviews(
            self.stockContainerView,
            self.titleLabel,
            self.plLabel,
            self.plArrowImage,
            self.priceLabel,
            self.avgPriceLabel,
            self.avgPriceValueLabel,
            self.leftDividorView,
            self.currentPriceLabel,
            self.currentPriceValueLabel,
            self.rightDividorView,
            self.amountLabel,
            self.amountValueLabel
        )
    }
    
    override func bindConstraints() {
        self.stockContainerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalTo(self.priceLabel).offset(8)
        }
        
        self.titleLabel.snp.makeConstraints { make in
            make.left.equalTo(self.stockContainerView).offset(16)
            make.top.equalTo(self.stockContainerView).offset(14)
            make.right.equalTo(self.plArrowImage.snp.left).offset(-10)
        }
        
        self.plLabel.snp.makeConstraints { make in
            make.right.equalTo(self.stockContainerView).offset(-16)
            make.top.equalTo(self.stockContainerView).offset(14)
        }
        
        self.plArrowImage.snp.makeConstraints { make in
            make.right.equalTo(self.plLabel.snp.left).offset(-2)
            make.centerY.equalTo(self.plLabel)
        }
        
        self.priceLabel.snp.makeConstraints { make in
            make.right.equalTo(self.stockContainerView).offset(-16)
            make.top.equalTo(self.plLabel.snp.bottom).offset(8)
        }
        
        self.avgPriceLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.stockContainerView.snp.bottom).offset(13)
        }
        
        self.avgPriceValueLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self.avgPriceLabel)
            make.top.equalTo(self.avgPriceLabel.snp.bottom).offset(2)
        }
        
        self.leftDividorView.snp.makeConstraints { make in
            make.top.equalTo(self.stockContainerView.snp.bottom).offset(20)
            make.right.equalTo(self.avgPriceLabel.snp.left).offset(-40)
            make.width.equalTo(1)
            make.height.equalTo(24)
        }
        
        self.currentPriceLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self.avgPriceLabel)
            make.right.equalTo(self.leftDividorView.snp.left).offset(-40)
        }
        
        self.currentPriceValueLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self.currentPriceLabel)
            make.centerY.equalTo(self.avgPriceValueLabel)
            make.bottom.equalToSuperview().offset(3)
        }
        
        self.rightDividorView.snp.makeConstraints { make in
            make.width.height.centerY.equalTo(self.leftDividorView)
            make.left.equalTo(self.avgPriceLabel.snp.right).offset(40)
        }
        
        self.amountLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self.avgPriceLabel)
            make.left.equalTo(self.rightDividorView.snp.right).offset(40)
        }
        
        self.amountValueLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self.avgPriceValueLabel)
            make.centerX.equalTo(self.amountLabel)
        }
    }
}
