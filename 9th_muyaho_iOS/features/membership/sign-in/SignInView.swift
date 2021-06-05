//
//  SignInView.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/04/28.
//

import UIKit

class SignInView: BaseView {
    
    let logoImage = UIImageView().then {
        $0.image = .imgLogoBig
    }
    
    let kakaoButton = UIButton().then {
        $0.layer.cornerRadius = 10
        $0.backgroundColor = UIColor(r: 247, g: 227, b: 23)
        $0.setTitle("sign_in_with_kakao".localized, for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.setImage(.kakaoLogo16, for: .normal)
        $0.titleLabel?.font = .caption1_12B
        $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: -8, bottom: 2, right: 8)
        $0.contentEdgeInsets = UIEdgeInsets(top: 15, left: 0, bottom: 15, right: 0)
    }
    
    let appleButton = UIButton().then {
        $0.layer.cornerRadius = 10
        $0.backgroundColor = .white
        $0.setTitle("sign_in_with_apple".localized, for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.setImage(.appleLogo16, for: .normal)
        $0.titleLabel?.font = .caption1_12B
        $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: -8, bottom: 2, right: 8)
        $0.contentEdgeInsets = UIEdgeInsets(top: 15, left: 0, bottom: 15, right: 0)
    }
    
    let bottomImage = UIImageView().then {
        $0.image = .imgBottomBackground
    }
    
    let rocketImage = UIImageView().then {
        $0.image = .imgRocket
    }
    
    override func setup() {
        self.backgroundColor = .sub_black_b1
        self.addSubviews(
            logoImage, kakaoButton, appleButton, bottomImage,
            rocketImage
        )
    }
    
    override func bindConstraints() {
        
        self.logoImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.safeAreaLayoutGuide).offset(195)
        }
        
        self.appleButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalTo(self.safeAreaLayoutGuide).offset(-21)
        }
        
        self.kakaoButton.snp.makeConstraints { make in
            make.left.right.equalTo(self.appleButton)
            make.bottom.equalTo(self.appleButton.snp.top).offset(-16)
        }
        
        self.bottomImage.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(self.kakaoButton.snp.top).offset(-30)
        }
        
        self.rocketImage.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-32)
            make.bottom.equalTo(self.bottomImage).offset(-102)
        }
    }
}
