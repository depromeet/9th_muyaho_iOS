//
//  StockDetailHeaderView.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/06/05.
//

import UIKit

class StockDetailHeaderView: BaseView {
    
    let totalCountLabel = UILabel().then {
        $0.font = .body1_16
        $0.textColor = .sub_white_w2
        $0.text = "총 2종목"
    }
    
    let settingButton = UIButton().then {
        $0.setImage(.icSetting, for: .normal)
    }
    
    let dividorView = UIView().then {
        $0.backgroundColor = .sub_black_b5
    }
    
    override func setup() {
        self.backgroundColor = .sub_black_b2
        self.addSubviews(
            self.totalCountLabel,
            self.settingButton,
            self.dividorView
        )
    }
    
    override func bindConstraints() {
        self.totalCountLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
        }
        
        self.settingButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16)
            make.centerY.equalTo(self.totalCountLabel)
        }
        
        self.dividorView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }
}
