//
//  DashBoardView.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/05/13.
//

import UIKit
import RxSwift
import RxCocoa

class DashBoardView: BaseView {
    
    let totalMoneyContainer = UIView().then {
        $0.backgroundColor = .sub_black_b3
        $0.layer.cornerRadius = 14
    }
    
    let totalMoneyTitleLabel = UILabel().then{
        $0.font = .body2_14R
        $0.textColor = .sub_white_w3
        $0.text = "home_total_title".localized
    }
    
    let seedMoneyLabel = UILabel().then {
        $0.font = .caption1_12B
        $0.textColor = .sub_white_w3
    }
    
    let totalMoneyLabel = UILabel().then {
        $0.font = .h3_30B
        $0.textColor = .sub_white_w2
    }
    
    let incommingRateContainer = UIView().then {
        $0.backgroundColor = .sub_black_b3
        $0.layer.cornerRadius = 14
    }
    
    let incommingRateTitleLabel = UILabel().then {
        $0.font = .caption1_12R
        $0.textColor = .sub_white_w3
        $0.text = "home_incoming_rate_title".localized
    }
    
    let incommingRateStackView = UIStackView().then {
        $0.spacing = 4
        $0.alignment = .center
        $0.axis = .horizontal
    }
    
    let incommingRateArrowImage = UIImageView().then {
        $0.image = .arrowUp
    }
    
    let incommingRateLabel = UILabel().then {
        $0.font = .subtitle2_18
        $0.textColor = .sub_white_w2
    }
    
    let incommingContainer = UIView().then {
        $0.backgroundColor = .sub_black_b3
        $0.layer.cornerRadius = 14
    }
    
    let incommingTitleLabel = UILabel().then {
        $0.font = .caption1_12R
        $0.textColor = .sub_white_w3
        $0.text = "home_incoming_title".localized
    }
    
    let incommingStackView = UIStackView().then {
        $0.spacing = 4
        $0.alignment = .center
        $0.axis = .horizontal
    }
    
    let incommingArrowImage = UIImageView().then {
        $0.image = .arrowUp
    }
    
    let incommingLabel = UILabel().then {
        $0.font = .subtitle2_18
        $0.textColor = .sub_white_w2
    }
    
    
    override func setup() {
        self.backgroundColor = .clear
        self.totalMoneyContainer.addSubviews(totalMoneyTitleLabel, seedMoneyLabel, totalMoneyLabel)
        self.incommingRateStackView.addArrangedSubview(incommingRateArrowImage)
        self.incommingRateStackView.addArrangedSubview(incommingRateLabel)
        self.incommingRateContainer.addSubviews(incommingRateTitleLabel, incommingRateStackView)
        self.incommingStackView.addArrangedSubview(incommingArrowImage)
        self.incommingStackView.addArrangedSubview(incommingLabel)
        self.incommingContainer.addSubviews(incommingTitleLabel, incommingStackView)
        self.addSubviews(totalMoneyContainer, incommingRateContainer, incommingContainer)
    }
    
    override func bindConstraints() {
        self.totalMoneyContainer.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalToSuperview()
            make.bottom.equalTo(self.totalMoneyLabel).offset(20)
        }
        
        self.totalMoneyTitleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalTo(self.totalMoneyContainer).offset(23)
        }
        
        self.seedMoneyLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self.totalMoneyTitleLabel)
            make.right.equalTo(self.totalMoneyContainer).offset(-16)
        }
        
        self.totalMoneyLabel.snp.makeConstraints { make in
            make.top.equalTo(self.seedMoneyLabel.snp.bottom).offset(20)
            make.right.equalTo(self.seedMoneyLabel)
        }
        
        self.incommingRateContainer.snp.makeConstraints { make in
            make.left.equalTo(self.totalMoneyContainer)
            make.top.equalTo(self.totalMoneyContainer.snp.bottom).offset(16)
            make.width.equalTo(100)
            make.bottom.equalTo(self.incommingRateLabel).offset(24)
        }
        
        self.incommingRateTitleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self.incommingRateContainer)
            make.top.equalTo(self.incommingRateContainer).offset(24)
        }
        
        self.incommingRateStackView.snp.makeConstraints { make in
            make.centerX.equalTo(self.incommingRateTitleLabel)
            make.top.equalTo(self.incommingRateTitleLabel.snp.bottom).offset(10)
        }
        
        self.incommingContainer.snp.makeConstraints { make in
            make.left.equalTo(self.incommingRateContainer.snp.right).offset(16)
            make.right.equalTo(self.totalMoneyContainer)
            make.top.bottom.equalTo(self.incommingRateContainer)
        }
        
        self.incommingTitleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self.incommingContainer)
            make.top.equalTo(self.incommingContainer).offset(24)
        }
        
        self.incommingStackView.snp.makeConstraints { make in
            make.centerX.equalTo(self.incommingTitleLabel)
            make.top.equalTo(self.incommingTitleLabel.snp.bottom).offset(10)
        }
        
        self.snp.makeConstraints { make in
            make.top.equalTo(self.totalMoneyContainer).priority(.high)
            make.bottom.equalTo(self.incommingContainer).offset(16).priority(.high)
        }
    }
    
    fileprivate func setFinalPL(pl: Double) {
        if pl > 0 {
            self.incommingRateArrowImage.image = .arrowUp
        } else {
            self.incommingRateArrowImage.image = .arrowDown
        }
        self.incommingRateLabel.text = pl.decimalString + "%"
    }
    
    fileprivate func setFinalAsset(asset: Double) {
        if asset > 0 {
            self.incommingArrowImage.image = .arrowUp
        } else {
            self.incommingArrowImage.image = .arrowDown
        }
        self.incommingLabel.text = asset.decimalString
    }
}

extension Reactive where Base: DashBoardView {
    
    var investStatus: Binder<InvestStatusResponse> {
        return Binder(self.base) { view, investStatus in
            view.seedMoneyLabel.text = "시드 " + investStatus.seedAmount.decimalString
            view.totalMoneyLabel.text = investStatus.finalAsset.decimalString
            view.setFinalPL(pl: investStatus.finalProfitOrLoseRate)
            view.setFinalAsset(asset: investStatus.finalAsset - investStatus.seedAmount)
        }
    }
}
