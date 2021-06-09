//
//  ShareView.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/06/08.
//

import UIKit
import RxSwift
import RxCocoa

class ShareView: BaseView {
    
    let backButton = UIButton().then {
        $0.setImage(.arrowLeft24, for: .normal)
    }
    
    let logoImage = UIImageView().then {
        $0.image = .imgLogo
    }
    
    let imageContainer = UIView()
    
    let youngchanImage = UIImageView().then {
        $0.image = .imgBigYoungchan2
    }
    
    let shareButton = UIButton().then {
        $0.backgroundColor = .sub_white_w2
        $0.layer.cornerRadius = 8
        $0.setTitle("이미지로 저장하기", for: .normal)
        $0.titleLabel?.font = .body2_14B
        $0.setTitleColor(.primary_default, for: .normal)
    }
    
    let slider = UISlider().then {
        $0.thumbTintColor = .sub_white_w2
        $0.backgroundColor = .clear
        $0.tintColor = .sub_white_w2
        $0.setThumbImage(UIImage(named: "img_thumb"), for: .normal)
        $0.setThumbImage(UIImage(named: "img_thumb"), for: .highlighted)
        $0.minimumTrackTintColor = .sub_white_w2
        $0.maximumTrackTintColor = UIColor(r: 177, g: 167, b: 255)
    }
    
    let plRateLabel = PaddingLabel(
        topInset: 8,
        bottomInset: 6,
        leftInset: 12,
        rightInset: 12
    ).then {
        $0.textColor = .sub_white_w2
        $0.font = .body2_14B
        $0.backgroundColor = .primary_dark
        $0.text = "+8.35%"
        $0.layer.cornerRadius = 17
        $0.layer.masksToBounds = true
    }
     
    let assetLabel = UILabel().then {
        $0.font = .h1_40
        $0.text = "23,455,668,000"
        $0.textColor = .sub_white_w2
    }
    
    let descriptionLabel = UILabel().then {
        $0.font = .body1_16
        $0.textColor = .sub_white_w2
        $0.text = "미래 내 돈은"
    }
    
    
    override func setup() {
        self.backgroundColor = .primary_default
        self.imageContainer.addSubview(self.youngchanImage)
        self.addSubviews(
            self.backButton,
            self.logoImage,
            self.imageContainer,
            self.shareButton,
            self.slider,
            self.plRateLabel,
            self.assetLabel,
            self.descriptionLabel
        )
    }
    
    override func bindConstraints() {
        self.backButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(self.safeAreaLayoutGuide).offset(9)
        }
        
        self.logoImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(self.backButton)
        }
        
        self.imageContainer.snp.makeConstraints { make in
            make.top.equalTo(self.backButton).offset(28)
            make.left.right.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.width)
        }
        
        self.youngchanImage.snp.makeConstraints { make in
            make.edges.equalTo(self.imageContainer)
        }
        
        self.shareButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(48)
            make.bottom.equalTo(self.safeAreaLayoutGuide).offset(-18)
        }
        
        self.slider.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalTo(self.shareButton.snp.top).offset(-58)
        }
        
        self.plRateLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.slider.snp.top).offset(-21)
            make.height.equalTo(34)
        }
        
        self.assetLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.plRateLabel.snp.top).offset(-28)
        }
        
        self.descriptionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.assetLabel.snp.top).offset(-10)
        }
    }
    
    fileprivate func setYoungchanImage(asset: Double) {
        switch asset {
        case _ where asset < 200000:
            self.youngchanImage.image = .imgBigYoungchan1
        case _ where asset <= 500000:
            self.youngchanImage.image = .imgBigYoungchan2
        case _ where asset <= 3000000:
            self.youngchanImage.image = .imgBigYoungchan3
        case _ where asset <= 10000000:
            self.youngchanImage.image = .imgBigYoungchan4
        case _ where asset <= 20000000:
            self.youngchanImage.image = .imgBigYoungchan5
        case _ where asset <= 50000000:
            self.youngchanImage.image = .imgBigYoungchan6
        case _ where asset <= 100000000:
            self.youngchanImage.image = .imgBigYoungchan7
        case _ where asset <= 300000000:
            self.youngchanImage.image = .imgBigYoungchan8
        case _ where asset <= 500000000:
            self.youngchanImage.image = .imgBigYoungchan9
        default:
            self.youngchanImage.image = .imgBigYoungchan10
        }
    }
}

extension Reactive where Base: ShareView {
    
    var plRate: Binder<Double> {
        return Binder(self.base) { view, plRate in
            view.slider.value = Float(plRate / 1000)
            view.plRateLabel.text = "+\(plRate.decimalString)%"
        }
    }
    
    var asset: Binder<Double> {
        return Binder(self.base) { view, asset in
            view.assetLabel.text = asset.decimalString
            view.setYoungchanImage(asset: asset)
        }
    }
}
