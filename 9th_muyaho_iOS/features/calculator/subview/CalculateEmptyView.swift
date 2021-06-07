//
//  CalculateEmptyView.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/06/07.
//

import UIKit

class CalculateEmptyView: BaseView {
    
    let titleLabel = UILabel().then {
        $0.font = .subtitle1_24
        $0.textColor = .sub_white_w1
        $0.text = "calculate_empty_title".localized
        $0.numberOfLines = 0
    }
    
    let youngchanImage = UIImageView().then {
        $0.image = .imgEmptyYoungchan
    }
    
    
    override func setup() {
        self.backgroundColor = .clear
        self.addSubviews(
            self.titleLabel,
            self.youngchanImage
        )
    }
    
    override func bindConstraints() {
        self.youngchanImage.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.right.equalToSuperview().offset(-20)
        }
        
        self.titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(self.youngchanImage).offset(10)
        }
        
        self.snp.makeConstraints { make in
            make.left.equalTo(self.titleLabel).priority(.high)
            make.right.equalTo(self.youngchanImage).priority(.high)
            make.top.bottom.equalTo(self.youngchanImage).priority(.high)
        }
    }
}
