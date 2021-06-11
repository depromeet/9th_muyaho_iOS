//
//  StockDetailHeaderView.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/06/05.
//

import UIKit
import RxSwift
import RxCocoa

class StockDetailHeaderView: BaseView {
    
    static let height: CGFloat = 56
    
    let totalCountLabel = UILabel().then {
        $0.font = .body1_16
        $0.textColor = .sub_white_w2
    }
    
    let settingButton = UIButton().then {
        $0.setImage(.icSetting, for: .normal)
    }
    
    let finishButton = UIButton().then {
        $0.setImage(.icCheck, for: .normal)
        $0.setTitle("common_finish".localized, for: .normal)
        $0.setTitleColor(.sub_white_w2, for: .normal)
        $0.titleLabel?.font = .caption1_12R
        $0.imageEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 6)
    }
    
    let dividorView = UIView().then {
        $0.backgroundColor = .sub_black_b5
    }
    
    override func setup() {
        self.backgroundColor = .sub_black_b2
        self.addSubviews(
            self.totalCountLabel,
            self.settingButton,
            self.finishButton,
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
        
        self.finishButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-19)
            make.centerY.equalTo(self.totalCountLabel)
        }
        
        self.dividorView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
    func bind(stocksCount: Int) {
        self.totalCountLabel.text = String(
            format: "stock_detail_count_format".localized,
            stocksCount
        )
    }
}

extension Reactive where Base: StockDetailHeaderView {
    
    var isEditable: Binder<Bool> {
        return Binder(self.base) { view, isEditable in
            view.settingButton.isHidden = isEditable
            view.finishButton.isHidden = !isEditable
        }
    }
}
