//
//  File.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/04/18.
//

import UIKit
import RxSwift
import RxCocoa

class HomeView: BaseView {
    
    var latestAngle: CGFloat = .zero
    
    let gradientLayer = CAGradientLayer().then {
        let topColor = UIColor.sub_black_b1.cgColor
        let middleColor = UIColor.sub_black_b1.withAlphaComponent(0.83).cgColor
        let bottomColor = UIColor.sub_black_b1.withAlphaComponent(0).cgColor
        
        $0.colors = [topColor, middleColor, bottomColor]
        $0.locations = [0.0, 0.5, 1.0]
    }
    
    let dimmedView = UIView()
    
    let logoImage = UIImageView().then {
        $0.image = .imgLogo
    }
    
    let refreshButton = UIButton().then {
        $0.setImage(.refresh, for: .normal)
    }
    
    let scrollView = UIScrollView().then {
        $0.contentInset = .init(
            top:  UIApplication.shared.windows[0].safeAreaInsets.top,
            left: 0,
            bottom: 0,
            right: 0
        )
        $0.showsVerticalScrollIndicator = false
    }
    
    let containerView = UIView()
    
    let homeOverview = HomeOverview()
    
    let homeInvestByCategoryView = HomeInvestByCategoryView()
    
    let writeButton = UIButton().then {
        $0.setImage(.icWrite, for: .normal)
    }
    
    let writeMenuView = WriteMenuView()
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.gradientLayer.frame = self.dimmedView.frame
    }
    
    override func setup() {
        self.backgroundColor = .sub_black_b1
        self.scrollView.delegate = self
        self.setupGradientLayer()
        self.containerView.addSubviews(homeOverview, homeInvestByCategoryView)
        self.scrollView.addSubviews(containerView)
        self.addSubviews(
            scrollView, dimmedView, logoImage, refreshButton,
            writeButton
        )
    }
    
    override func bindConstraints() {
        self.dimmedView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.top).offset(65)
        }
        
        self.logoImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(self.refreshButton)
        }
        
        self.refreshButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalTo(self.dimmedView).offset(-32)
        }
        
        self.scrollView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.bottom.equalTo(self.safeAreaLayoutGuide)
        }
        
        self.containerView.snp.makeConstraints { make in
            make.edges.equalTo(0)
            make.left.right.equalToSuperview()
            make.width.equalTo(self.scrollView)
            make.top.equalTo(self.homeOverview)
            make.bottom.equalTo(self.homeInvestByCategoryView)
        }
        
        self.homeOverview.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
        }
        
        self.homeInvestByCategoryView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.homeOverview.snp.bottom)
            make.bottom.equalToSuperview()
        }
        
        self.writeButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-4)
            make.bottom.equalTo(self.safeAreaLayoutGuide).offset(-24)
        }
    }
    
    func setRefreshAnimation(isLoading: Bool) {
        if isLoading {
            let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
            rotateAnimation.fromValue = 0.0
            rotateAnimation.toValue = CGFloat(Double.pi * 2)
            rotateAnimation.isRemovedOnCompletion = false
            rotateAnimation.duration = 2
            rotateAnimation.repeatCount=Float.infinity
            self.refreshButton.layer.add(rotateAnimation, forKey: nil)
        } else {
            self.refreshButton.layer.removeAllAnimations()
        }
    }
    
    private func setupGradientLayer() {
        self.dimmedView.layer.addSublayer(self.gradientLayer)
    }
}


extension HomeView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        let angle = offset * CGFloat(Double.pi / 180)
        
        self.homeOverview.starImageView1.transform = .init(rotationAngle: -angle)
        self.homeOverview.starImageView2.transform = .init(rotationAngle: angle * 0.7)

        if 1000 - offset  <= UIScreen.main.bounds.height {
            self.homeInvestByCategoryView.rocketImage.transform = .init(rotationAngle: -0.3 * (angle - self.latestAngle))
                .translatedBy(x: -140 * (angle - self.latestAngle), y: -70 * (angle - self.latestAngle))
        } else {
            self.latestAngle = angle
        }
    }
}

extension Reactive where Base: HomeView {
    
    var investStatus: Binder<InvestStatusResponse> {
        return Binder(self.base) { view, investStatus in
            view.homeOverview.rx.investStatus.onNext(investStatus)
            view.homeInvestByCategoryView.rx.overView.onNext(investStatus.overview)
        }
    }
}
