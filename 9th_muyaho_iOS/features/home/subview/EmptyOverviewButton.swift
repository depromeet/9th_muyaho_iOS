//
//  EmptyOverviewButton.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/05/13.
//

import UIKit

class EmptyOverviewButton: UIButton {
    
    let plusImage = UIImageView().then {
        $0.image = .plus
    }

    let textLabel = UILabel().then {
        $0.text = "home_empty_overview".localized
        $0.textColor = .sub_gray_40
        $0.font = .caption1_12B
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setup()
        self.bindConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.layer.cornerRadius = 14
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.sub_gray_40.cgColor
        self.addSubviews(plusImage, textLabel)
    }
    
    private func bindConstraints() {
        self.plusImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(33)
        }
        
        self.textLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.plusImage.snp.bottom).offset(12)
            make.bottom.equalToSuperview().offset(33).priority(.high)
        }
        
        self.snp.makeConstraints { make in
            make.top.equalTo(self.plusImage).offset(-33)
            make.bottom.equalTo(self.textLabel).offset(33)
        }
    }
}
