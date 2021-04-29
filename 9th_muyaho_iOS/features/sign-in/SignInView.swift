//
//  SignInView.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/04/28.
//

import UIKit

class SignInView: BaseView {
    
    let kakaoButton = UIButton().then {
        $0.layer.cornerRadius = 10
        $0.backgroundColor = UIColor(r: 247, g: 227, b: 23)
        $0.setTitle("sign_in_with_kakao".localized, for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.setImage(.kakaoLogo16, for: .normal)
        $0.titleLabel?.font = .caption1_12B
        $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: -8, bottom: 2, right: 8)
        $0.contentEdgeInsets = UIEdgeInsets(top: 12, left: 0, bottom: 10, right: 0)
    }
    
    let appleButton = UIButton().then {
        $0.layer.cornerRadius = 10
        $0.backgroundColor = .white
        $0.setTitle("sign_in_with_apple".localized, for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.setImage(.appleLogo16, for: .normal)
        $0.titleLabel?.font = .caption1_12B
        $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: -8, bottom: 2, right: 8)
        $0.contentEdgeInsets = UIEdgeInsets(top: 12, left: 0, bottom: 10, right: 0)
    }
    
    override func setup() {
        self.backgroundColor = .sub_black_B1
        self.addSubviews(kakaoButton, appleButton)
    }
    
    override func bindConstraints() {
        self.appleButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalTo(self.safeAreaLayoutGuide).offset(-21)
        }
        
        self.kakaoButton.snp.makeConstraints { make in
            make.left.right.equalTo(self.appleButton)
            make.bottom.equalTo(self.appleButton.snp.top).offset(-16)
        }
    }
}
