//
//  MyPageView.swift
//  9th_muyaho_iOS
//
//  Created by 이현호 on 2021/05/09.
//

import UIKit

final class MyPageView: BaseView {
    
    private let logoImageView = UIImageView().then {
        $0.image = .imgLogo
    }
    
    private let socialImage = UIImageView().then {
        $0.image = .icKakao
    }
    
    private let titleLabel = UILabel().then {
        $0.font = .h3_30L
        $0.textColor = .sub_white_w2
        $0.text = "my_page_title_format".localized
    }
    
    private let signOutButton = UIButton().then {
        $0.setTitle("my_page_signout".localized, for: .normal)
        $0.setTitleColor(.primary_default, for: .normal)
        $0.titleLabel?.font = .caption1_12B
        $0.backgroundColor = .sub_white_w2
        $0.layer.cornerRadius = 8
    }
    
    private let withdrawalButton = UIButton().then {
        $0.backgroundColor = .clear
        $0.setTitle("my_page_withdrawal".localized, for: .normal)
        $0.setTitleColor(.sub_white_w2, for: .normal)
        $0.titleLabel?.font = .caption1_12R
    }
    
    override func setup() {
        backgroundColor = .primary_default
        addSubviews(
            self.logoImageView,
            self.socialImage,
            self.titleLabel,
            self.signOutButton,
            self.withdrawalButton
        )
    }
    
    override func bindConstraints() {
        self.logoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.safeAreaLayoutGuide).offset(12)
        }
        
        self.socialImage.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(self.logoImageView.snp.bottom).offset(61)
        }
        
        self.titleLabel.snp.makeConstraints { make in
            make.left.equalTo(self.socialImage.snp.right).offset(10)
            make.top.equalTo(self.socialImage).offset(-7)
        }
        
        self.withdrawalButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalTo(self.safeAreaLayoutGuide).offset(-35)
            make.height.equalTo(40)
        }
        
        self.signOutButton.snp.makeConstraints { make in
            make.left.right.equalTo(self.withdrawalButton)
            make.bottom.equalTo(withdrawalButton.snp.top).offset(-10)
            make.height.equalTo(40)
        }
    }
}
