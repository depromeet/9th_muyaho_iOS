//
//  StockDetailOverviewCell.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/06/05.
//

import UIKit

class StockDetailOverviewCell: BaseTableViewCell {
    
    static let registerId = "\(StockDetailOverviewCell.self)"
    
    let totalMoneyLabel = UILabel().then {
        $0.font = .h2_36
        $0.textColor = .sub_white_w2
        $0.text = "1,500,000"
    }
    
    let descriptionLabel = UILabel().then {
        $0.font = .caption1_12R
        $0.textColor = .sub_white_w2
        $0.text = "현재 국내 자산(원)"
    }
    
    let plContainerView = UIView().then {
        $0.layer.cornerRadius = 13
        $0.backgroundColor = .sub_white_w2
    }
    
    let plArrowImage = UIImageView().then {
        $0.image = .arrowDown
    }
    
    let plLabel = UILabel().then {
        $0.font = .caption1_12R
        $0.textColor = .secondary_blue_default
        $0.text = "120,402원"
    }
    
    let starImage = UIImageView().then {
        $0.image = .imgStarSolid
    }
    
    let youngchanImage = UIImageView().then {
        $0.image = .imgKoreanYoungchan
    }
    
    let groundImage = UIImageView().then {
        $0.image = .imgGround
    }
    
    let groundView = UIView().then {
        $0.backgroundColor = .sub_black_b2
    }
    
    
    override func setup() {
        self.backgroundColor = .primary_dark
        self.selectionStyle = .none
        self.addSubviews(
            self.totalMoneyLabel,
            self.descriptionLabel,
            self.plContainerView,
            self.plArrowImage,
            self.plLabel,
            self.starImage,
            self.groundImage,
            self.groundView,
            self.youngchanImage
        )
    }
    
    override func bindConstraints() {
        self.totalMoneyLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(62)
        }
        
        self.descriptionLabel.snp.makeConstraints { make in
            make.left.equalTo(self.totalMoneyLabel)
            make.top.equalTo(self.totalMoneyLabel.snp.bottom).offset(6)
        }
        
        self.plContainerView.snp.makeConstraints { make in
            make.left.equalTo(self.totalMoneyLabel)
            make.top.equalTo(self.descriptionLabel.snp.bottom).offset(20)
            make.right.equalTo(self.plLabel).offset(8)
            make.height.equalTo(24)
        }
        
        self.plArrowImage.snp.makeConstraints { make in
            make.left.equalTo(self.plContainerView).offset(8)
            make.centerY.equalTo(self.plContainerView)
        }
        
        self.plLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self.plArrowImage)
            make.left.equalTo(self.plArrowImage.snp.right).offset(2)
        }
        
        self.starImage.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(17)
            make.top.equalTo(self.plContainerView.snp.bottom).offset(19)
        }
        
        self.youngchanImage.snp.makeConstraints { make in
            make.bottom.equalTo(self.groundView)
            make.right.equalToSuperview().offset(-20)
        }
        
        self.groundImage.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.plContainerView.snp.bottom).offset(50)
        }
        
        self.groundView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.groundImage.snp.bottom)
            make.height.equalTo(40)
            make.bottom.equalToSuperview()
        }
    }
    
    func bind(type: StockType, totalMoney: Double, pl: Double) {
        self.setYoungchan(by: type)
        self.totalMoneyLabel.text = totalMoney.decimalString
        self.setProfitOrLose(pl: pl)
    }
    
    private func setYoungchan(by type: StockType) {
        switch type {
        case .domestic:
            self.youngchanImage.image = .imgKoreanYoungchan
        case .abroad:
            self.youngchanImage.image = .imgAmericanYoungchan
        case .coin:
            self.youngchanImage.image = .imgCoinYoungchan
        }
    }
    
    private func setProfitOrLose(pl: Double) {
        self.plArrowImage.image = pl >= 0 ? .arrowUp : .arrowDown
        self.plLabel.text = pl.decimalString + "원"
        if pl >= 0 {
            self.plLabel.textColor = .secondary_red_default
        } else {
            self.plLabel.textColor = .secondary_blue_default
        }
    }
}
