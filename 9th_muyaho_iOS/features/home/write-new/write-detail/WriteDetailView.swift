//
//  WriteDetailView.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/05/29.
//

import UIKit

class WriteDetailView: BaseView {
    
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
    }
    
    let avgPriceField = DeletableInputField()
    
    
    
    override func setup() {
        self.backgroundColor = .sub_black_b1
        self.containerView.addSubviews(
            descriptionLabel, stockContainerView, stockTypeLabel, stockNameLabel,
            totalPriceLabel, avgPriceLabel, avgPriceField
        )
        self.scrollView.addSubview(containerView)
        self.addSubviews(
            backButton, titleLabel, closeButton, scrollView
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
            make.bottom.equalTo(self.avgPriceField)
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
    }
}
