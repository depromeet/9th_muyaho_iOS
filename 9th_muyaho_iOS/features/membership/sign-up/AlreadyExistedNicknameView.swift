//
//  AlreadyExistedNicknameView.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/04/30.
//

import UIKit

class AlreadyExistedNicknameView: BaseView {
    
    let infoImage = UIImageView().then {
        $0.image = .info
    }
    
    let label = UILabel().then {
        $0.text = "sign_up_already_existed_nickname".localized
        $0.textColor = .secondary_red_default
        $0.font = .caption1_12R
    }
    
    
    override func setup() {
        self.backgroundColor = .sub_white_w2
        self.layer.cornerRadius = 12
        self.addSubviews(infoImage, label)
    }
    
    override func bindConstraints() {
        self.infoImage.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(6)
            make.top.equalToSuperview().offset(6)
            make.bottom.equalToSuperview().offset(-6)
        }
        
        self.label.snp.makeConstraints { make in
            make.centerY.equalTo(self.infoImage)
            make.left.equalTo(self.infoImage.snp.right).offset(4)
            make.right.equalToSuperview().offset(-10)
        }
    }
}
