//
//  CalculateYoungchanView.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/06/08.
//

import UIKit

class CalculateYoungchanView: BaseView {
    
    let titleLabel = UILabel().then {
        $0.font = .body2_14R
        $0.textColor = .sub_white_w2
        $0.text = "calculate_title".localized
    }
    
    let assetLabel = UILabel().then {
        $0.font = .h2_36
        $0.textColor = .sub_white_w2
        $0.text = "566,800,000"
        $0.textAlignment = .right
    }
    
    let youngchanImage = UIImageView()
    
    let plLabel = PaddingLabel(
        topInset: 5,
        bottomInset: 5,
        leftInset: 14,
        rightInset: 14
    ).then {
        $0.font = .caption1_12B
        $0.textColor = .secondary_red_default
        $0.text = "+8.35%"
        $0.layer.cornerRadius = 9
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.secondary_red_default.cgColor
    }
    
    override func setup() {
        self.addSubviews(
            self.titleLabel,
            self.assetLabel,
            self.youngchanImage,
            self.plLabel
        )
    }
    
    override func bindConstraints() {
        self.youngchanImage.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview()
        }
        
        self.titleLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(self.youngchanImage).offset(11)
        }
        
        self.assetLabel.snp.makeConstraints { make in
            make.right.equalTo(self.titleLabel)
            make.top.equalTo(self.titleLabel.snp.bottom).offset(10)
        }
        
        self.plLabel.snp.makeConstraints { make in
            make.right.equalTo(self.titleLabel)
            make.top.equalTo(self.assetLabel.snp.bottom).offset(16)
        }
        
        self.snp.makeConstraints { make in
            make.left.top.bottom.equalTo(self.youngchanImage).priority(.high)
            make.right.equalTo(titleLabel).priority(.high)
        }
    }
}
