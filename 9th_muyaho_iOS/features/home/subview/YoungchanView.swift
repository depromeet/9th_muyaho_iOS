//
//  YoungchanView.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/05/12.
//

import UIKit
import RxSwift
import RxCocoa

class YoungchanView: BaseView {
    
    let youngchanImage = UIImageView().then {
        $0.image = .imgYoungchanGray
    }
    
    let leftLabel = PaddingLabel(
        topInset: 6,
        bottomInset: 6,
        leftInset: 12,
        rightInset: 12
    ).then {
        $0.font = .caption1_12B
        $0.textColor = .white
        $0.backgroundColor = UIColor(r: 208, g: 208, b: 208)
        $0.text = "zzzzz...."
        $0.layer.cornerRadius = 15
        $0.layer.masksToBounds = true
        $0.textAlignment = .center
    }
    
    let rightLabel = PaddingLabel(
        topInset: 6,
        bottomInset: 6,
        leftInset: 12,
        rightInset: 12
    ).then {
        $0.font = .caption1_12B
        $0.textColor = .white
        $0.backgroundColor = UIColor(r: 208, g: 208, b: 208)
        $0.text = "zzzzz...."
        $0.layer.cornerRadius = 15
        $0.layer.masksToBounds = true
        $0.textAlignment = .center
    }
    
    
    override func setup() {
        self.backgroundColor = .clear
        self.addSubviews(youngchanImage, leftLabel, rightLabel)
    }
    
    override func bindConstraints() {
        self.youngchanImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        self.leftLabel.snp.makeConstraints { make in
            make.top.equalTo(self.youngchanImage).offset(24)
            make.left.equalTo(self.youngchanImage).offset(-28)
            make.height.equalTo(30)
        }
        
        self.rightLabel.snp.makeConstraints { make in
            make.bottom.equalTo(self.youngchanImage).offset(-24)
            make.right.equalTo(self.youngchanImage.snp.right).offset(28)
            make.height.equalTo(30)
        }
        
        self.snp.makeConstraints { make in
            make.left.equalTo(self.leftLabel)
            make.right.equalTo(self.rightLabel)
            make.top.bottom.equalTo(self.youngchanImage)
        }
    }
    
    func setYoungChanImage(by status: InvestmentStatus) {
        switch status {
        case .empty:
            self.youngchanImage.image = .imgYoungchanGray
        case .profit:
            self.youngchanImage.image = .imgYoungchanRed
        case .lose:
            self.youngchanImage.image = .imgYoungchanBlue
        }
    }
    
    func setYoungChanLabel(by status: InvestmentStatus) {
        switch status{
        case .empty:
            self.leftLabel.text = "home_youngchan_empty_left".localized
            self.rightLabel.text = "home_youngchan_empty_right".localized
        case .profit:
            self.setUpStateRandomLabel()
        case .lose:
            self.setDownStateRandomLabel()
        }
    }
    
    private func setUpStateRandomLabel() {
        let randomIndex = Int.random(in: 1...3)
        
        self.leftLabel.text = "home_youngchan_up_left_\(randomIndex)".localized
        self.rightLabel.text = "home_youngchan_up_right_\(randomIndex)".localized
    }
    
    private func setDownStateRandomLabel() {
        let randomIndex = Int.random(in: 1...3)
        
        self.leftLabel.text = "home_youngchan_down_left_\(randomIndex)".localized
        self.rightLabel.text = "home_youngchan_down_right_\(randomIndex)".localized
    }
}

extension Reactive where Base: YoungchanView {
    
    var status: Binder<InvestmentStatus> {
        return Binder(self.base) { view, status in
            view.setYoungChanImage(by: status)
            view.setYoungChanLabel(by: status)
        }
    }
}
