//
//  StockDetailItemCell.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/06/05.
//

import UIKit
import RxSwift
import RxCocoa

class StockDetailItemCell: BaseTableViewCell {
    
    static let registerId = "\(StockDetailItemCell.self)"
    var type: StockType = .domestic
    
    let stockContainerView = UIView().then {
        $0.layer.cornerRadius = 14
        $0.backgroundColor = .sub_black_b4
    }
    
    let titleLabel = UILabel().then {
        $0.font = .subtitle2_18
        $0.textColor = .sub_white_w1
    }
    
    let plLabel = UILabel().then {
        $0.font = .caption1_12R
        $0.textColor = .secondary_red_default
    }
    
    let plArrowImage = UIImageView().then {
        $0.image = .arrowUp
    }
    
    let priceLabel = UILabel().then {
        $0.font = .subtitle1_24
        $0.textColor = .sub_white_w1
    }
    
    let avgPriceLabel = UILabel().then {
        $0.font = .caption1_12R
        $0.textColor = .sub_white_w1
        $0.text = "common_average_price".localized
    }
    
    let avgPriceValueLabel = UILabel().then {
        $0.font = .body1_16
        $0.textColor = .sub_gray_20
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
    }
    
    // Setting Model
    let editButton = UIButton().then {
        $0.setImage(.icEdit, for: .normal)
        $0.setTitle("stock_detail_edit".localized, for: .normal)
        $0.setTitleColor(.sub_white_w2, for: .normal)
        $0.titleLabel?.font = .body2_14R
        $0.imageEdgeInsets = .init(top: 0, left: -8, bottom: 0, right: 8)
        $0.isHidden = true
    }
    
    let deleteButton = UIButton().then {
        $0.setImage(.icDeleteDetail, for: .normal)
        $0.setTitle("stock_detail_delete".localized, for: .normal)
        $0.setTitleColor(.secondary_red_default, for: .normal)
        $0.titleLabel?.font = .body2_14R
        $0.imageEdgeInsets = .init(top: 0, left: -8, bottom: 0, right: 8)
        $0.isHidden = true
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
            self.purchasedAvgValueLabel,
            self.editButton,
            self.deleteButton
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
        
        self.editButton.snp.makeConstraints { make in
            make.centerY.equalTo(self.centerDividorView)
            make.right.equalTo(self.centerDividorView.snp.left).offset(-42)
        }
        
        self.deleteButton.snp.makeConstraints { make in
            make.centerY.equalTo(self.centerDividorView)
            make.left.equalTo(self.centerDividorView.snp.right).offset(43)
        }
    }
    
    func bind(stock: StockCalculateResponse) {
        let type = stock.stock.type
        self.type = type
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
            // TODO: 매수 평균가는 어떻게 계산하지..?
            self.purchasedAvgValueLabel.text = stock.current.won.amountPrice.decimalString
        }
    }
    
    fileprivate func setEditable(isEditable: Bool) {
        self.editButton.isHidden = !isEditable
        self.deleteButton.isHidden = !isEditable
        
        if self.type == .coin {
            self.coinCurrentPriceLabel.isHidden = isEditable
            self.coinCurrentPriceValueLabel.isHidden = isEditable
            self.purchasedAvgLabel.isHidden = isEditable
            self.purchasedAvgValueLabel.isHidden = isEditable
        } else {
            self.centerDividorView.isHidden = !isEditable
            self.currentPriceLabel.isHidden = isEditable
            self.currentPriceValueLabel.isHidden = isEditable
            self.avgPriceLabel.isHidden = isEditable
            self.avgPriceValueLabel.isHidden = isEditable
            self.amountLabel.isHidden = isEditable
            self.amountValueLabel.isHidden = isEditable
            self.leftDividorView.isHidden = isEditable
            self.rightDividorView.isHidden = isEditable
        }
    }
}

extension Reactive where Base: StockDetailItemCell {
    
    var isEditable: Binder<Bool> {
        return Binder(self.base) { view, isEditable in
            view.setEditable(isEditable: isEditable)
        }
    }
}
