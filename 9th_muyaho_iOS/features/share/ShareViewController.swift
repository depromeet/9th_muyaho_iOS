//
//  ShareViewController.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/06/08.
//

import UIKit

class ShareViewController: BaseViewController {
    
    private let shareView = ShareView()
    
    static func instance() -> ShareViewController {
        return ShareViewController(nibName: nil, bundle: nil).then {
            $0.hidesBottomBarWhenPushed = true
        }
    }
    
    
    override func loadView() {
        self.view = shareView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func bindEvent() {
        self.shareView.backButton.rx.tap
            .asDriver()
            .drive(onNext: self.popVC)
            .disposed(by: self.eventDisposeBag)
    }
    
    private func popVC() {
        self.navigationController?.popViewController(animated: true)
    }
}
