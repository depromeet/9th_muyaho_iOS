//
//  StockDetailView.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/06/05.
//

import UIKit

class StockDetailView: BaseView {
    
    let backButton = UIButton().then {
        $0.setImage(.arrowLeft24, for: .normal)
    }
    
    let refreshButton = UIButton().then {
        $0.setImage(.refresh, for: .normal)
    }
    
    let domesticButton = UIButton().then {
        $0.setTitle("investment_category_demestic".localized, for: .normal)
        $0.titleLabel?.font = .body1_16
        $0.setTitleColor(.sub_white_w1, for: .normal)
    }
    
    let abroadButton = UIButton().then {
        $0.setTitle("investment_category_abroad".localized, for: .normal)
        $0.titleLabel?.font = .body1_16
        $0.setTitleColor(.sub_white_w1, for: .normal)
    }
    
    let coinButton = UIButton().then {
        $0.setTitle("investment_category_coin".localized, for: .normal)
        $0.titleLabel?.font = .body1_16
        $0.setTitleColor(.sub_white_w1, for: .normal)
    }
    
    let indicatorView = UIView().then {
        $0.backgroundColor = .sub_white_w2
    }
    
    let patternImage = UIImageView().then {
        $0.image = .imgPattern
    }
    
    let containerView = UIView()
    
    override func setup() {
        self.backgroundColor = .primary_dark
        self.addSubviews(
            backButton, refreshButton, domesticButton, abroadButton,
            coinButton, indicatorView, containerView, patternImage
        )
    }
    
    override func bindConstraints() {
        self.backButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(self.safeAreaLayoutGuide).offset(9)
        }
        
        self.refreshButton.snp.makeConstraints { make in
            make.centerY.equalTo(self.backButton)
            make.right.equalToSuperview().offset(-20)
        }
        
        self.domesticButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(self.backButton.snp.bottom).offset(23)
        }
        
        self.abroadButton.snp.makeConstraints { make in
            make.centerY.equalTo(self.domesticButton)
            make.left.equalTo(self.domesticButton.snp.right).offset(22)
        }
        
        self.coinButton.snp.makeConstraints { make in
            make.centerY.equalTo(self.domesticButton)
            make.left.equalTo(self.abroadButton.snp.right).offset(22)
        }
        
        self.indicatorView.snp.makeConstraints { make in
            make.centerX.equalTo(self.domesticButton)
            make.top.equalTo(self.domesticButton.snp.bottom)
            make.width.equalTo(56)
            make.height.equalTo(2)
        }
        
        self.containerView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(self.indicatorView.snp.bottom)
        }
        
        self.patternImage.snp.makeConstraints { make in
            make.top.right.equalToSuperview()
        }
    }
}
