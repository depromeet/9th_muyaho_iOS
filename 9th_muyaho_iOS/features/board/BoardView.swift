//
//  BoardView.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/06/06.
//

import UIKit

class BoardView: BaseView {
    
    let tbdYoungchanImage = UIImageView().then {
        $0.image = .icTbdEmpty
        $0.alpha = 0.4
    }
    
    let tbdLabel = UILabel().then {
        $0.font = .subtitle1_24
        $0.textColor = UIColor(r: 98, g: 97, b: 103)
        $0.text = "my_page_tbd".localized
    }
    
    override func setup() {
        self.backgroundColor = .sub_black_b1
        self.addSubviews(
            self.tbdYoungchanImage,
            self.tbdLabel
        )
    }
    
    override func bindConstraints() {
        self.tbdYoungchanImage.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        self.tbdLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.tbdYoungchanImage.snp.bottom).offset(34)
        }
    }
}
