//
//  HomeOverViewCell.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/05/11.
//

import UIKit

class HomeOverview: BaseView {
    
    let titleLabel = UILabel().then {
        $0.textColor = .sub_white_w2
        $0.numberOfLines = 0
        $0.font = .subtitle1_24
        $0.text = "home_empty_title".localized
        $0.textAlignment = .center
    }
    
    let youngchanView = YoungchanView()
    
    let starImageView1 = UIImageView().then {
        $0.image = .imgStar1
    }
    
    let starImageView2 = UIImageView().then {
        $0.image = .imgStar2
    }
    
    let emptyOverViewButton = EmptyOverviewButton()
    
    
    override func setup() {
        self.backgroundColor = .clear
        self.addSubviews(
            titleLabel, youngchanView, starImageView1, starImageView2,
            emptyOverViewButton
        )
    }
    
    override func bindConstraints() {
        self.titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(24).priority(.high)
        }
        
        self.starImageView1.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel).offset(26)
            make.right.equalToSuperview()
        }

        self.youngchanView.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
        }

        self.starImageView2.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(-21)
            make.centerY.equalTo(self.youngchanView.snp.bottom)
        }

        self.emptyOverViewButton.snp.makeConstraints { make in
            make.top.equalTo(self.starImageView2.snp.bottom).offset(3)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }

        self.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel).offset(-24)
            make.bottom.equalTo(self.emptyOverViewButton).offset(20).priority(.high)
        }
    }
}
