//
//  WriteDetailView.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/05/29.
//

import UIKit
import RxSwift
import RxCocoa

class WriteDetailView: BaseView {
    
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
        $0.text = "write_detail_description".localized
        $0.numberOfLines = 0
    }
    
    let stockContainerView = UIView().then {
        $0.backgroundColor = .sub_white_w1
        $0.layer.cornerRadius = 16
    }
    
    let stockTypeLabel = UILabel().then {
        $0.font = .caption1_12R
        $0.textColor = .sub_black_b4
        $0.text = "국내주식"
        $0.contentHuggingPriority(for: .vertical)
    }
    
    let stockNameLabel = UILabel().then {
        $0.font = .subtitle2_18
        $0.textColor = .sub_black_b1
        $0.text = "삼성전자"
    }
    
    let totalPriceLabel = UILabel().then {
        $0.textColor = .sub_gray_40
        $0.font = .subtitle1_24
        $0.text = "0"
        $0.textAlignment = .right
    }
    
    let avgPriceLabel = UILabel().then {
        $0.font = .caption1_12R
        $0.textColor = .sub_white_w3
        $0.text = "common_average_price".localized
        $0.contentHuggingPriority(for: .horizontal)
    }
    
    let avgPriceField = DeletableInputField().then {
        $0.textfield.placeholder = "0"
        $0.textfield.keyboardType = .decimalPad
    }
    
    let amountLabel = UILabel().then {
        $0.font = .caption1_12R
        $0.textColor = .sub_white_w3
        $0.text = "common_amount".localized
    }
    
    let amountField = DeletableInputField().then {
        $0.textfield.placeholder = "0개"
        $0.textfield.keyboardType = .numberPad
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
            descriptionLabel, stockContainerView, stockTypeLabel, stockNameLabel,
            totalPriceLabel, avgPriceLabel, avgPriceField, amountLabel,
            amountField
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
            make.bottom.equalTo(self.amountField)
        }
        
        self.descriptionLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview()
        }
        
        self.stockContainerView.snp.makeConstraints { make in
            make.top.equalTo(self.descriptionLabel.snp.bottom).offset(26)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalTo(self.stockNameLabel).offset(12)
        }
        
        self.stockTypeLabel.snp.makeConstraints { make in
            make.left.equalTo(self.stockContainerView).offset(16)
            make.top.equalTo(self.stockContainerView).offset(14)
        }
        
        self.stockNameLabel.snp.makeConstraints { make in
            make.left.equalTo(self.stockTypeLabel)
            make.top.equalTo(self.stockTypeLabel.snp.bottom).offset(12)
        }
        
        self.totalPriceLabel.snp.makeConstraints { make in
            make.right.equalTo(self.stockContainerView).offset(-8)
            make.centerY.equalTo(self.stockNameLabel)
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
        
        self.saveButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalTo(self.safeAreaLayoutGuide).offset(-37)
        }
    }
    
    func hideKeyboard() {
        self.endEditing(true)
    }
}

extension Reactive where Base: WriteDetailView {
    
    var isSaveEnable: Binder<Bool> {
        return Binder(self.base) { view, isEnable in
            view.saveButton.backgroundColor = isEnable ? .primary_default : .primary_default.withAlphaComponent(0.5)
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
            
            view.totalPriceLabel.text = formatter.string(from: NSNumber(value: totalPrice))
            if totalPrice == 0 {
                view.totalPriceLabel.textColor = .sub_gray_40
            } else {
                view.totalPriceLabel.textColor = .sub_black_b1
            }
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
                
                view.avgPriceField.textfield.text = formatter.string(from: NSNumber(value: avgPrice))
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
