//
//  ShareViewController.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/06/08.
//

import UIKit
import RxSwift
import RxCocoa
import ReactorKit

class ShareViewController: BaseViewController, View {
    
    private let shareView = ShareView()
    private let shareReactor: ShareReactor
    
    
    init(asset: Double, plRate: Double) {
        self.shareReactor = ShareReactor(plRate: plRate, asset: asset)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func instance(asset: Double, plRate: Double) -> ShareViewController {
        return ShareViewController(asset: asset, plRate: plRate).then {
            $0.hidesBottomBarWhenPushed = true
        }
    }
    
    override func loadView() {
        self.view = shareView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.reactor = self.shareReactor
    }
    
    override func bindEvent() {
        self.shareView.backButton.rx.tap
            .asDriver()
            .drive(onNext: self.popVC)
            .disposed(by: self.eventDisposeBag)
    }
    
    func bind(reactor: ShareReactor) {
        // MARK: Bind Action
        self.shareView.slider.rx.value
            .skip(1)
            .map { Reactor.Action.plRate(Double($0 * 1000)) }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        self.shareView.shareButton.rx.tap
            .map { Reactor.Action.tapShareButton }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        // MARK: Bind State
        reactor.state
            .map { $0.plRate }
            .asDriver(onErrorJustReturn: 0)
            .drive(self.shareView.rx.plRate)
            .disposed(by: self.disposeBag)
        
        reactor.state
            .map { $0.asset }
            .asDriver(onErrorJustReturn: 0)
            .drive(self.shareView.rx.asset)
            .disposed(by: self.disposeBag)
    }
    
    private func popVC() {
        self.navigationController?.popViewController(animated: true)
    }
}
