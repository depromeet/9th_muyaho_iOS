//
//  HomeInvestByCategoryView.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/05/13.
//

import UIKit
import RxSwift
import RxCocoa

class HomeInvestByCategoryView: BaseView {
    
    let headerLabel = UILabel().then {
        $0.font = .subtitle1_24
        $0.textColor = .sub_white_w2
        $0.text = "home_invent_by_category_header_format".localized
    }
    
    let domesticCategoryButton = InvestByCategoryButton()
    
    let abroadCategoryButton = InvestByCategoryButton()
    
    let coinCategoryButton = InvestByCategoryButton()
    
    let bottomBackgroundImage = UIImageView().then {
        $0.image = .imgBottomBackground
    }
    
    let rocketImage = UIImageView().then {
        $0.image = .imgRocket
    }
    
    
    override func setup() {
        self.backgroundColor = .clear
        self.addSubviews(
            rocketImage, headerLabel, domesticCategoryButton, abroadCategoryButton,
            coinCategoryButton, bottomBackgroundImage
        )
    }
    
    override func bindConstraints() {
        self.headerLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(36).priority(.high)
        }
        
        self.domesticCategoryButton.snp.makeConstraints { make in
            make.left.equalTo(self.headerLabel)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(self.headerLabel.snp.bottom).offset(24)
        }
        
        self.abroadCategoryButton.snp.makeConstraints { make in
            make.left.right.equalTo(self.domesticCategoryButton)
            make.top.equalTo(self.domesticCategoryButton.snp.bottom).offset(16)
        }
        
        self.coinCategoryButton.snp.makeConstraints { make in
            make.left.right.equalTo(self.abroadCategoryButton)
            make.top.equalTo(self.abroadCategoryButton.snp.bottom).offset(16)
        }
        
        self.bottomBackgroundImage.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().priority(.high)
            make.top.equalTo(self.coinCategoryButton).offset(31)
        }
        
        self.rocketImage.snp.makeConstraints { make in
            make.right.equalTo(self.bottomBackgroundImage).offset(-32)
            make.top.equalTo(self.bottomBackgroundImage).offset(38)
        }
        
        self.snp.makeConstraints { make in
            make.top.equalTo(self.headerLabel.snp.top).offset(-36)
            make.bottom.equalTo(self.bottomBackgroundImage)
        }
    }
}

extension Reactive where Base: HomeInvestByCategoryView {
    
    var overView: Binder<OverviewStocksResponse> {
        return Binder(self.base) { view , overview in
            view.headerLabel.text = String(
                format: "home_invent_by_category_header_format".localized,
                overview.bitCoins.count + overview.domesticStocks.count + overview.foreignStocks.count
            )
            view.domesticCategoryButton.rx.stockCalculate.onNext((.domestic, overview.domesticStocks))
            view.abroadCategoryButton.rx.stockCalculate.onNext((.abroad, overview.foreignStocks))
            view.coinCategoryButton.rx.stockCalculate.onNext((.coin, overview.bitCoins))
        }
    }
}
