//
//  CalculateField.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/06/07.
//

import UIKit

class CalculateField: BaseView {
    
    let containerView = UIView().then {
        $0.backgroundColor = .sub_black_b3
        $0.layer.cornerRadius = 10
    }
    
    let textField = UITextField().then {
        $0.font = .caption1_12R
        $0.textColor = .sub_white_w2
    }
    
    
    override func setup() {
        self.addSubviews(
            self.containerView,
            self.textField
        )
    }
    
    override func bindConstraints() {
        self.containerView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
            make.height.equalTo(40)
        }
        
        self.textField.snp.makeConstraints { make in
            make.left.equalTo(self.containerView).offset(13)
            make.right.equalTo(self.containerView).offset(-13)
            make.top.equalTo(self.containerView).offset(11)
            make.bottom.equalTo(self.containerView).offset(-11)
        }
    }
    
    func setAttributedPlaceholder(placeholder: String) {
        let attributedString = NSMutableAttributedString(
            string: placeholder,
            attributes: [
                .foregroundColor: UIColor.sub_gray_40,
                .font: UIFont.caption1_12R!
            ])
        
        self.textField.attributedPlaceholder = attributedString
    }
}
