//
//  AbroadDetailView.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/05/31.
//

import UIKit
import RxSwift
import RxCocoa

class AbroadDetailView: BaseView {
    
    let tapBackground = UITapGestureRecognizer()
    
    let backButton = UIButton().then {
        $0.setImage(.arrowLeft24, for: .normal)
    }
    
    let titleLabel = UILabel().then {
        $0.font = .body1_16
        $0.textColor = .sub_white_w1
        $0.text = "write_detail_title".localized
    }
    
    let closeButton = UIButton().then {
        $0.setImage(.close24, for: .normal)
    }
    
    let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
        $0.backgroundColor = .clear
    }
    
    let containerView = UIView().then {
        $0.backgroundColor = .clear
    }
    
    let descriptionLabel = UILabel().then {
        $0.font = .subtitle1_24
        $0.textColor = .sub_white_w1
        $0.text = "해외투자 종목의\n가격과 수량을 알려주세요!"
        $0.numberOfLines = 0
    }
    
    let stockContainerView = UIView().then {
        $0.backgroundColor = .sub_white_w1
        $0.layer.cornerRadius = 16
    }
    
    let stockNameLabel = UILabel().then {
        $0.font = .subtitle2_18
        $0.textColor = .sub_black_b1
    }
    
    let totalPriceLabel = UILabel().then {
        $0.textColor = .sub_gray_40
        $0.font = .subtitle1_24
        $0.text = "0원"
        $0.textAlignment = .right
    }
    
    let avgPriceLabel = UILabel().then {
        $0.font = .caption1_12R
        $0.textColor = .sub_white_w3
        $0.text = "common_average_price".localized
        $0.contentHuggingPriority(for: .horizontal)
    }
    
    let avgPriceField = DeletableInputField().then {
        $0.textfield.placeholder = "0 USD"
        $0.textfield.keyboardType = .decimalPad
    }
    
    let amountLabel = UILabel().then {
        $0.font = .caption1_12R
        $0.textColor = .sub_white_w3
        $0.text = "수량"
    }
    
    let amountField = DeletableInputField().then {
        $0.textfield.placeholder = "0개"
        $0.textfield.keyboardType = .numberPad
    }
    
    let optionLabel = UILabel().then {
        $0.font = .subtitle2_18
        $0.textColor = .sub_white_w1
        $0.text = "write_detail_option_title".localized
    }
    
    let optionDescriptionLabel = UILabel().then {
        $0.font = .caption1_12R
        $0.textColor = .sub_white_w1
        $0.text = "write_detail_option_description".localized
        $0.numberOfLines = 0
    }
    
    let transitionRateLabel = UILabel().then {
        $0.font = .caption1_12R
        $0.textColor = .sub_white_w3
        $0.text = "write_detail_transition_rate".localized
    }
    
    let transitionRateValueLabel = UILabel().then {
        $0.font = .body1_16
        $0.textColor = .sub_gray_40
        $0.text = "0"
    }
    
    let standardLabel = UILabel().then {
        $0.font = .caption1_12R
        $0.textColor = .sub_black_b5
        $0.text = "write_detail_standard".localized
    }
    
    let purchasedMoneyLabel = UILabel().then {
        $0.font = .caption1_12R
        $0.textColor = .sub_white_w3
        $0.text = "write_detail_purchased_money".localized
    }
    
    let purchasedMoneyField = DeletableInputField().then {
        $0.textfield.placeholder = "0원"
        $0.textfield.keyboardType = .decimalPad
    }
    
    let saveButton = UIButton().then {
        $0.layer.cornerRadius = 8
        $0.titleLabel?.font = .caption1_12B
        $0.setTitle("write_detail_save".localized, for: .normal)
        $0.setTitleColor(.sub_gray_20, for: .disabled)
        $0.setTitleColor(.sub_white_w2, for: .normal)
        $0.contentEdgeInsets = .init(top: 11, left: 0, bottom: 11, right: 0)
        $0.backgroundColor = .primary_default
        $0.layer.shadowColor = UIColor.primary_default.cgColor
        $0.layer.shadowOffset = CGSize(width: 4, height: 4)
        $0.layer.shadowOpacity = 0.4
    }
    
    
    override func setup() {
        self.backgroundColor = .sub_black_b1
        self.addGestureRecognizer(self.tapBackground)
        self.containerView.addSubviews(
            descriptionLabel, stockContainerView, stockNameLabel,
            totalPriceLabel, avgPriceLabel, avgPriceField, amountLabel,
            amountField, optionLabel, optionDescriptionLabel,
            transitionRateLabel, transitionRateValueLabel, standardLabel, purchasedMoneyLabel,
            purchasedMoneyField
        )
        self.scrollView.addSubview(containerView)
        self.addSubviews(
            backButton, titleLabel, closeButton, scrollView,
            saveButton
        )
    }
    
    override func bindConstraints() {
        self.titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.safeAreaLayoutGuide).offset(11)
        }
        
        self.backButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.centerY.equalTo(self.titleLabel)
        }
        
        self.closeButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-20)
            make.centerY.equalTo(self.titleLabel)
        }
        
        self.scrollView.snp.makeConstraints { make in
            make.top.equalTo(self.backButton.snp.bottom).offset(32)
            make.left.bottom.right.equalToSuperview()
        }
        
        self.containerView.snp.makeConstraints { make in
            make.edges.equalTo(0)
            make.width.equalTo(UIScreen.main.bounds.width)
            make.top.equalTo(self.descriptionLabel)
            make.bottom.equalTo(self.purchasedMoneyField)
        }
        
        self.descriptionLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview()
        }
        
        self.stockContainerView.snp.makeConstraints { make in
            make.top.equalTo(self.descriptionLabel.snp.bottom).offset(26)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalTo(self.totalPriceLabel).offset(8)
        }
        
        self.stockNameLabel.snp.makeConstraints { make in
            make.left.equalTo(self.stockContainerView).offset(16)
            make.top.equalTo(self.stockContainerView).offset(12)
        }
        
        self.totalPriceLabel.snp.makeConstraints { make in
            make.right.equalTo(self.stockContainerView).offset(-8)
            make.top.equalTo(self.stockNameLabel.snp.bottom).offset(4)
        }
        
        self.avgPriceLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(24)
            make.top.equalTo(self.stockContainerView.snp.bottom).offset(51)
        }
        
        self.avgPriceField.snp.makeConstraints { make in
            make.left.equalTo(self.avgPriceLabel.snp.right).offset(24)
            make.centerY.equalTo(self.avgPriceLabel)
            make.right.equalToSuperview().offset(-24)
        }
        
        self.amountLabel.snp.makeConstraints { make in
            make.left.equalTo(self.avgPriceLabel)
            make.top.equalTo(self.avgPriceLabel.snp.bottom).offset(46)
        }
        
        self.amountField.snp.makeConstraints { make in
            make.left.equalTo(self.amountLabel.snp.right).offset(36)
            make.centerY.equalTo(self.amountLabel)
            make.right.equalToSuperview().offset(-24)
        }
        
        self.optionLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(24)
            make.top.equalTo(self.amountField.snp.bottom).offset(81)
        }
        
        self.optionDescriptionLabel.snp.makeConstraints { make in
            make.left.equalTo(self.optionLabel)
            make.top.equalTo(self.optionLabel.snp.bottom).offset(15)
        }
        
        self.transitionRateLabel.snp.makeConstraints { make in
            make.left.equalTo(self.optionLabel)
            make.top.equalTo(self.optionDescriptionLabel.snp.bottom).offset(34)
        }
        
        self.transitionRateValueLabel.snp.makeConstraints { make in
            make.left.equalTo(self.transitionRateLabel.snp.right).offset(14)
            make.centerY.equalTo(self.transitionRateLabel)
        }
        
        self.standardLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-24)
            make.centerY.equalTo(self.transitionRateLabel)
        }
        
        self.purchasedMoneyLabel.snp.makeConstraints { make in
            make.left.equalTo(self.transitionRateLabel)
            make.top.equalTo(self.transitionRateLabel.snp.bottom).offset(45)
        }
        
        self.purchasedMoneyField.snp.makeConstraints { make in
            make.left.equalTo(self.transitionRateValueLabel)
            make.right.equalToSuperview().offset(-24)
            make.centerY.equalTo(self.purchasedMoneyLabel)
        }
        
        self.saveButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalTo(self.safeAreaLayoutGuide).offset(-37)
            make.height.equalTo(40)
        }
    }
    
    func hideKeyboard() {
        self.endEditing(true)
    }
}

extension Reactive where Base: AbroadDetailView {
    
    var isSaveEnable: Binder<Bool> {
        return Binder(self.base) { view, isEnable in
            view.saveButton.backgroundColor = isEnable ? .primary_default
                : UIColor(r: 45, g: 36, b: 125)
            if isEnable {
                view.saveButton.layer.shadowOpacity = 0.4
            } else {
                view.saveButton.layer.shadowOpacity = 0
            }
        }
    }
    
    var totalPrice: Binder<Double> {
        return Binder(self.base) { view, totalPrice in
            let formatter = NumberFormatter().then {
                $0.numberStyle = .decimal
                $0.locale = .current
            }
            
            let totalPriceString = formatter.string(from: NSNumber(value: totalPrice)) ?? ""
            
            view.totalPriceLabel.text = totalPriceString + " 원"
            if totalPrice == 0 {
                view.totalPriceLabel.textColor = .sub_gray_40
            } else {
                view.totalPriceLabel.textColor = .sub_black_b1
            }
        }
    }
    
    var purchasedMoney: Binder<Double> {
        return Binder(self.base) { view, totalPrice in
            let formatter = NumberFormatter().then {
                $0.numberStyle = .decimal
                $0.locale = .current
            }
            
            let totalPriceString = formatter.string(from: NSNumber(value: totalPrice)) ?? ""
            
            view.purchasedMoneyField.textfield.text = totalPrice == 0 ? nil : (totalPriceString + " 원")
        }
    }
    
    var avgPrice: Binder<Double> {
        return Binder(self.base) { view, avgPrice in
            if avgPrice == 0 {
                view.avgPriceField.textfield.text = nil
            } else {
                let formatter = NumberFormatter().then {
                    $0.numberStyle = .decimal
                    $0.locale = .current
                }
                
                view.avgPriceField.textfield.text = (formatter.string(from: NSNumber(value: avgPrice)) ?? "") + " USD"
            }
        }
    }
    
    var amount: Binder<Int> {
        return Binder(self.base) { view, amount in
            if amount == 0 {
                view.amountField.textfield.text = nil
            } else {
                view.amountField.textfield.text = "\(amount) 개"
            }
        }
    }
}
