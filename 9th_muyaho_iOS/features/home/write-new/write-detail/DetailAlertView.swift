//
//  DetailAlertView.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/05/31.
//

import UIKit

class DetailAlertView: BaseView {
    
    let dimmedView = UIView().then {
        $0.backgroundColor = .black
        $0.alpha = 0.8
    }
    
    let containerView = UIView().then {
        $0.backgroundColor = .sub_gray_80
        $0.layer.cornerRadius = 14
    }
    
    let titleLabel = UILabel().then {
        $0.font = .subtitle2_18
        $0.textColor = .sub_white_w1
        $0.text = "write_detail_cancel_title".localized
    }
    
    let descriptionLabel = UILabel().then {
        $0.font = .caption1_12R
        $0.textColor = .sub_gray_40
        $0.text = "write_detail_cancel_description".localized
        $0.numberOfLines = 0
    }
    
    let continueButton = UIButton().then {
        $0.layer.cornerRadius = 8
        $0.setTitle("write_detail_continue".localized, for: .normal)
        $0.setTitleColor(.sub_gray_20, for: .normal)
        $0.titleLabel?.font = .body2_14B
        $0.backgroundColor = .sub_gray_60
    }
    
    let exitButton = UIButton().then {
        $0.layer.cornerRadius = 8
        $0.setTitle("write_detail_exit".localized, for: .normal)
        $0.setTitleColor(.sub_white_w2, for: .normal)
        $0.titleLabel?.font = .body2_14B
        $0.backgroundColor = .secondary_red_default
    }
    
    
    override func setup() {
        self.backgroundColor = .clear
        self.addSubviews(
            dimmedView, containerView, titleLabel, descriptionLabel,
            continueButton, exitButton
        )
    }
    
    override func bindConstraints() {
        self.dimmedView.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
        
        self.containerView.snp.makeConstraints { make in
            make.left.equalTo(self.continueButton).offset(-16)
            make.right.equalTo(self.exitButton).offset(16)
            make.top.equalTo(self.titleLabel).offset(-24)
            make.bottom.equalTo(self.continueButton).offset(16)
        }
        
        self.titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.descriptionLabel.snp.top).offset(-8)
        }
        
        self.descriptionLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        self.continueButton.snp.makeConstraints { make in
            make.top.equalTo(self.descriptionLabel.snp.bottom).offset(30)
            make.right.equalTo(self.snp.centerX).offset(-4)
            make.width.equalTo(120)
            make.height.equalTo(40)
        }
        
        self.exitButton.snp.makeConstraints { make in
            make.centerY.equalTo(self.continueButton)
            make.left.equalTo(self.snp.centerX).offset(4)
            make.width.equalTo(120)
            make.height.equalTo(40)
        }
    }
    
    func bind(type: DetailAlertViewController.AlertType) {
        switch type {
        case .detail:
            self.titleLabel.text = "write_detail_cancel_title".localized
            self.descriptionLabel.text = "write_detail_cancel_description".localized
            self.continueButton.setTitle("write_detail_continue".localized, for: .normal)
            self.exitButton.setTitle("write_detail_exit".localized, for: .normal)
        case .delete:
            self.titleLabel.text = "stock_detail_alert_title".localized
            self.descriptionLabel.text = "stock_detail_alert_description".localized
            self.continueButton.setTitle("stock_detail_next_time".localized, for: .normal)
            self.exitButton.setTitle("stock_detail_delete".localized, for: .normal)
        }
    }
}
