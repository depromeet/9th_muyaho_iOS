//
//  DetailAlertViewController.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/05/31.
//

import UIKit

class DetailAlertViewController: BaseViewController {
    
    enum AlertType {
        case delete
        case detail
    }
    
    var onExit: (() -> ())?
    private let detailAlertView = DetailAlertView()
    private let type: AlertType
    
    init(type: AlertType) {
        self.type = type
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func instance(type: AlertType) -> DetailAlertViewController {
        return DetailAlertViewController(type: type).then {
            $0.modalPresentationStyle = .overCurrentContext
            $0.modalTransitionStyle = .crossDissolve
        }
    }
    
    override func setupView() {
        self.view.addSubview(self.detailAlertView)
        
        self.detailAlertView.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
        self.detailAlertView.bind(type: self.type)
    }
    
    override func bindEvent() {
        self.detailAlertView.continueButton.rx.tap
            .asDriver()
            .drive(onNext: self.dismiss)
            .disposed(by: self.disposeBag)
        
        self.detailAlertView.exitButton.rx.tap
            .asDriver()
            .drive(onNext: exit)
            .disposed(by: self.disposeBag)
    }
    
    private func dismiss() {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func exit() {
        self.onExit?()
        self.dismiss(animated: true, completion: nil)
    }
}
