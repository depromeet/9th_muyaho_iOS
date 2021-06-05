//
//  InvestByCategoryButton.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/05/13.
//

import UIKit
import RxSwift
import RxCocoa

class InvestByCategoryButton: UIButton {
    
    let mainTitleLabel = UILabel().then {
        $0.font = .body1_16
        $0.textColor = UIColor(r: 236, g: 236, b: 236)
        $0.text = "investment_category_demestic".localized
        $0.isUserInteractionEnabled = false
    }
    
    let subTitleLabel = UILabel().then {
        $0.font = .caption1_12R
        $0.textColor = .sub_black_b5
        $0.text = "home_category_register".localized
        $0.isUserInteractionEnabled = false
    }
    
    let rightArrowImage = UIImageView().then {
        $0.image = .arrowRight16
        $0.isUserInteractionEnabled = false
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setup()
        self.bindConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setPL(pl: Double) {
        if pl > 0 {
            self.subTitleLabel.textColor = .secondary_red_default
            self.subTitleLabel.text = "+" + pl.roundUpTwoString + "원"
        } else {
            self.subTitleLabel.textColor = .secondary_blue_default
            self.subTitleLabel.text = pl.roundUpTwoString + "원"
        }
    }
    
    private func setup() {
        self.backgroundColor = .sub_black_b3
        self.layer.cornerRadius = 8
        self.addSubviews(mainTitleLabel, subTitleLabel, rightArrowImage)
    }
    
    private func bindConstraints() {
        self.mainTitleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
        
        self.rightArrowImage.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10).priority(.high)
            make.centerY.equalToSuperview()
        }
        
        self.subTitleLabel.snp.makeConstraints { make in
            make.right.equalTo(self.rightArrowImage.snp.left).offset(-16)
            make.centerY.equalToSuperview()
        }
        
        self.snp.makeConstraints { make in
            make.left.equalTo(self.mainTitleLabel).offset(-16)
            make.right.equalTo(self.rightArrowImage).offset(10)
            make.top.equalTo(self.mainTitleLabel).offset(-17).priority(.high)
            make.bottom.equalTo(self.mainTitleLabel).offset(16).priority(.high)
        }
    }
}

extension Reactive where Base: InvestByCategoryButton {
    
    var stockCalculate: Binder<(type: StockType, overview: [StockCalculateResponse])> {
        return Binder(self.base) { view, stockCalculate in
            view.mainTitleLabel.text = stockCalculate.type.localizedString
            
            if stockCalculate.type == .abroad {
                let pl = stockCalculate.overview
                    .map { $0.current.won.amountPrice - $0.purchase.amountInWon }
                    .reduce(0, +)
                view.setPL(pl: pl)
            } else {
                let pl = stockCalculate.overview
                    .map { $0.current.won.amountPrice - $0.purchase.amount }
                    .reduce(0, +)
                view.setPL(pl: pl)
            }
        }
    }
}
