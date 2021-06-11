//
//  CalculateYoungchanView.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/06/08.
//

import UIKit
import RxSwift
import RxCocoa

class CalculateYoungchanView: BaseView {
    
    let titleLabel = UILabel().then {
        $0.font = .body2_14R
        $0.textColor = .sub_white_w2
        $0.text = "calculate_title".localized
    }
    
    let assetLabel = UILabel().then {
        $0.font = .h2_36
        $0.textColor = .sub_white_w2
        $0.textAlignment = .right
    }
    
    let youngchanImage = UIImageView().then {
        $0.image = .imgYoungchan1
    }
    
    let plLabel = PaddingLabel(
        topInset: 5,
        bottomInset: 5,
        leftInset: 14,
        rightInset: 14
    ).then {
        $0.font = .caption1_12B
        $0.textColor = .secondary_red_default
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
    
    fileprivate func setYoungchanImage(plMoney: Int) {
        switch plMoney {
        case _ where plMoney < 200000:
            self.youngchanImage.image = .imgYoungchan1
        case _ where plMoney <= 500000:
            self.youngchanImage.image = .imgYoungchan2
        case _ where plMoney <= 3000000:
            self.youngchanImage.image = .imgYoungchan3
        case _ where plMoney <= 10000000:
            self.youngchanImage.image = .imgYoungchan4
        case _ where plMoney <= 20000000:
            self.youngchanImage.image = .imgYoungchan5
        case _ where plMoney <= 50000000:
            self.youngchanImage.image = .imgYoungchan6
        case _ where plMoney <= 100000000:
            self.youngchanImage.image = .imgYoungchan7
        case _ where plMoney <= 300000000:
            self.youngchanImage.image = .imgYoungchan8
        case _ where plMoney <= 500000000:
            self.youngchanImage.image = .imgYoungchan9
        default:
            self.youngchanImage.image = .imgYoungchan10
        }
    }
}

extension Reactive where Base: CalculateYoungchanView {
    
    var pl: Binder<(Int, Int)> {
        return Binder(self.base) { view, pl in
            let plMoney = pl.0
            let plRate = pl.1
            
            view.assetLabel.text = plMoney.decimalString
            
            if plRate >= 0 {
                view.plLabel.text = "+\(plRate)%"
                view.plLabel.textColor = .secondary_red_default
                view.plLabel.layer.borderColor = UIColor.secondary_red_default.cgColor
            } else {
                view.plLabel.text = "\(plRate)%"
                view.plLabel.textColor = .secondary_blue_default
                view.plLabel.layer.borderColor = UIColor.secondary_blue_default.cgColor
            }
            view.setYoungchanImage(plMoney: plMoney)
        }
    }
}
