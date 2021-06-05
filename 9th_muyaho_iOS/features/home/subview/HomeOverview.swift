//
//  HomeOverViewCell.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/05/11.
//

import UIKit
import RxSwift
import RxCocoa

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
    
    let emptyOverViewButton = EmptyOverviewButton().then {
        $0.isHidden = true
    }
    
    let dashboardView = DashBoardView()
    
    
    override func setup() {
        self.backgroundColor = .clear
        self.addSubviews(
            titleLabel, youngchanView, starImageView1, starImageView2,
            dashboardView, emptyOverViewButton
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
        
        self.dashboardView.snp.makeConstraints { make in
            make.top.equalTo(self.starImageView2.snp.bottom).offset(3)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }

        self.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel).offset(-24)
            make.bottom.equalTo(self.dashboardView).offset(20).priority(.high)
        }
    }
    
    fileprivate func setEmptyDashboard(isEmpty: Bool) {
        self.emptyOverViewButton.isHidden = !isEmpty
        self.dashboardView.isHidden = isEmpty
        self.snp.remakeConstraints { make in
            make.top.equalTo(self.titleLabel).offset(-24)
            make.left.right.equalToSuperview()
            if isEmpty {
                make.bottom.equalTo(self.emptyOverViewButton).offset(20).priority(.high)
            } else {
                make.bottom.equalTo(self.dashboardView).offset(20).priority(.high)
            }
        }
    }
    
    fileprivate func setTitle(isEmpty: Bool, todayPL: Double) {
        if isEmpty {
            self.setEmptyTitle()
        } else {
            self.setTodayPLTitle(todayPL: todayPL)
        }
    }
    
    private func setEmptyTitle() {
        self.titleLabel.text = "home_empty_title".localized
        self.titleLabel.font = .subtitle1_24
    }
    
    private func setTodayPLTitle(todayPL: Double) {
        let todayPLString = self.isProfit(pl: todayPL) ?
            "+" + todayPL.decimalString :
            "-" + todayPL.decimalString
        let text = "home_today_pl_title".localized + todayPLString
        let attributedString = NSMutableAttributedString(string: text)
        let attributedRange = (text as NSString).range(of: todayPLString)
        
        attributedString.addAttributes([
            .foregroundColor: todayPL > 0 ? UIColor.secondary_red_default : UIColor.secondary_blue_default,
            .font: UIFont.h3_30B!
        ], range: attributedRange)
        
        self.titleLabel.font = .h3_30L
        self.titleLabel.attributedText = attributedString
    }
    
    private func isProfit(pl: Double) -> Bool {
        return pl > 0
    }
}

extension Reactive where Base: HomeOverview {
    
    var investStatus: Binder<InvestStatusResponse> {
        return Binder(base.self) { view, status in
            let isEmpty = status.seedAmount == 0
            
            view.setEmptyDashboard(isEmpty: isEmpty)
            view.setTitle(isEmpty: isEmpty, todayPL: status.todayProfitOrLose)
            view.youngchanView.rx.status.onNext(status.todayStatus)
        }
    }
}
