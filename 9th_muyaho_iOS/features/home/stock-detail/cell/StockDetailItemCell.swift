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
    }
    
    // Bitcoin Component
    let coinCurrentPriceLabel = UILabel().then {
        $0.font = .caption1_12R
        $0.textColor = .sub_white_w1
        $0.text = "common_current_price".localized
    }
    
    let coinCurrentPriceValueLabel = UILabel().then {
        $0.font = .body1_16
        $0.textColor = .sub_gray_20
        $0.text = "19,415,678"
    }
    
    let centerDividorView = UIView().then {
        $0.backgroundColor = UIColor(r: 150, g: 150, b: 150)
    }
    
    let purchasedAvgLabel = UILabel().then {
        $0.font = .caption1_12R
        $0.textColor = .sub_white_w1
        $0.text = "stock_detail_purchased_average".localized
    }
    
    let purchasedAvgValueLabel = UILabel().then {
        $0.font = .body1_16
        $0.textColor = .sub_gray_20
        $0.text = "94,778"
    }
    
    // Setting Model
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
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
            self.amountValueLabel,
            self.coinCurrentPriceLabel,
            self.coinCurrentPriceValueLabel,
            self.centerDividorView,
            self.purchasedAvgLabel,
            self.purchasedAvgValueLabel
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
        
        self.centerDividorView.snp.makeConstraints { make in
            make.top.equalTo(self.stockContainerView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(1)
            make.height.equalTo(24)
        }
        
        self.coinCurrentPriceLabel.snp.makeConstraints { make in
            make.top.equalTo(self.stockContainerView.snp.bottom).offset(13)
            make.right.equalTo(self.centerDividorView.snp.left).offset(-66)
        }
        
        self.coinCurrentPriceValueLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self.coinCurrentPriceLabel)
            make.top.equalTo(self.coinCurrentPriceLabel.snp.bottom).offset(2)
        }
        
        self.purchasedAvgLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self.coinCurrentPriceLabel)
            make.left.equalTo(self.centerDividorView.snp.right).offset(58)
        }
        
        self.purchasedAvgValueLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self.coinCurrentPriceValueLabel)
            make.centerX.equalTo(self.purchasedAvgLabel)
        }
    }
    
    func bind(stock: StockCalculateResponse) {
        let type = stock.stock.type
        let pl = stock.current.won.amountPrice - stock.purchase.amount
        
        self.plLabel.text = pl.decimalString + "(" + stock.profitOrLoseRate + "%)"
        self.plArrowImage.image = pl >= 0 ? .arrowUp : .arrowDown
        self.plLabel.textColor = pl >= 0 ? .secondary_red_default : .secondary_blue_default
        self.priceLabel.text = stock.current.won.amountPrice.decimalString
        self.titleLabel.text = stock.stock.name
        
        self.currentPriceLabel.isHidden = type == .coin
        self.currentPriceValueLabel.isHidden = type == .coin
        self.avgPriceLabel.isHidden = type == .coin
        self.avgPriceValueLabel.isHidden = type == .coin
        self.amountLabel.isHidden = type == .coin
        self.amountValueLabel.isHidden = type == .coin
        self.leftDividorView.isHidden = type == .coin
        self.rightDividorView.isHidden = type == .coin
        self.centerDividorView.isHidden = type != .coin
        self.coinCurrentPriceLabel.isHidden = type != .coin
        self.coinCurrentPriceValueLabel.isHidden = type != .coin
        self.purchasedAvgLabel.isHidden = type != .coin
        self.purchasedAvgValueLabel.isHidden = type != .coin
        
        switch type {
        case .domestic:
            self.currentPriceValueLabel.text = stock.current.won.unitPrice.decimalString
            self.avgPriceValueLabel.text = stock.purchase.unitPrice.decimalString
            self.amountValueLabel.text = stock.quantity
        case .abroad:
            self.currentPriceValueLabel.text = stock.current.won.unitPrice.decimalString
            self.avgPriceValueLabel.text = stock.purchase.unitPrice.decimalString
            self.amountValueLabel.text = stock.quantity
        case .coin:
            self.coinCurrentPriceValueLabel.text = stock.current.won.unitPrice.decimalString
            // 매수 평균가는 어떻게 계산하지..?
            self.purchasedAvgValueLabel.text = stock.current.won.amountPrice.decimalString
        }
//        let pl = stock.current.won.amountPrice - stock.purchase.amount
//        self.titleLabel.text = stock.stock.name
//        self.plLabel.text = pl.decimalString + "(" + stock.profitOrLoseRate + "%)"
//        self.plArrowImage.image = pl >= 0 ? .arrowUp : .arrowDown
//        self.plLabel.textColor = pl >= 0 ? .secondary_red_default : .secondary_blue_default
//        self.priceLabel.text = stock.current.won.amountPrice.decimalString
//        self.currentPriceValueLabel.text = stock.current.won.unitPrice.decimalString
//        self.avgPriceValueLabel.text = stock.purchase.unitPrice.decimalString
//        self.amountValueLabel.text = stock.quantity
    }
}
