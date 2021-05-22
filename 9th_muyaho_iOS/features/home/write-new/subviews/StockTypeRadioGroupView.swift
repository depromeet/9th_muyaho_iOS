//
//  StockTypeRadioGroupView.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/05/20.
//

import UIKit
import RxSwift
import RxCocoa

class StockTypeRadioGroupView: BaseView {
  
    let itemSpacing = 15
    let itemWidth = (UIScreen.main.bounds.width - 40 - 30) / 3
    
    let categoryPublishSubject = PublishSubject<StockType>()
    
    let domesticButton = StockTypeButton().then {
        $0.setTitle("investment_category_demestic".localized, for: .normal)
    }
    
    let abroadButton = StockTypeButton().then {
        $0.setTitle("investment_category_abroad".localized, for: .normal)
    }
    
    let coinButton = StockTypeButton().then {
        $0.setTitle("investment_category_coin".localized, for: .normal)
    }
    
    
    override func setup() {
        self.backgroundColor = .clear
        self.addSubviews(domesticButton, abroadButton, coinButton)
        
        self.domesticButton.rx.tap
            .map { StockType.domestic }
            .bind(to: self.categoryPublishSubject)
            .disposed(by: self.disposeBag)
        
        self.abroadButton.rx.tap
            .map { StockType.abroad }
            .bind(to: self.categoryPublishSubject)
            .disposed(by: self.disposeBag)
        
        self.coinButton.rx.tap
            .map { StockType.coin }
            .bind(to: self.categoryPublishSubject)
            .disposed(by: self.disposeBag)
    }
    
    override func bindConstraints() {
        self.abroadButton.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().priority(.high)
            make.width.equalTo(self.itemWidth)
            make.centerX.equalToSuperview().priority(.high)
        }
        
        self.domesticButton.snp.makeConstraints { make in
            make.centerY.equalTo(self.abroadButton)
            make.width.equalTo(self.itemWidth)
            make.right.equalTo(self.abroadButton.snp.left).offset(-15)
        }
        
        self.coinButton.snp.makeConstraints { make in
            make.centerY.equalTo(self.abroadButton)
            make.width.equalTo(self.itemWidth)
            make.left.equalTo(self.abroadButton.snp.right).offset(15)
        }
        
        self.snp.makeConstraints { make in
            make.top.bottom.equalTo(self.abroadButton)
            make.left.equalTo(self.domesticButton)
            make.right.equalTo(self.coinButton)
        }
    }
    
    func selectButton(type: StockType) {
        self.domesticButton.isSelected = type == .domestic
        self.abroadButton.isSelected = type == .abroad
        self.coinButton.isSelected = type == .coin
    }
}

extension Reactive where Base: StockTypeRadioGroupView {
    
    var category: ControlEvent<StockType> {
        let event = ControlEvent(events: PublishSubject<StockType>())
        return event
    }
    
    var select: Binder<StockType> {
        return Binder(self.base) { view, stockType in
            view.selectButton(type: stockType)
        }
    }
}
