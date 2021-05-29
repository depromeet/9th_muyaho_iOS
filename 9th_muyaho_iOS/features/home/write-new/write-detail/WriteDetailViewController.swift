//
//  WriteDetailViewController.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/05/29.
//

import UIKit

class WriteDetailViewController: BaseViewController {
    
    private let writeDetailView = WriteDetailView()
    
    
    static func make() -> WriteDetailViewController {
        return WriteDetailViewController(nibName: nil, bundle: nil)
    }
    
    override func setupView() {
        self.view.addSubview(writeDetailView)
        self.writeDetailView.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
    }
    
    override func bindEvent() {
        self.writeDetailView.backButton.rx.tap
            .asDriver()
            .drive(onNext: self.popViewController)
            .disposed(by: self.eventDisposeBag)
        
        self.writeDetailView.closeButton.rx.tap
            .asDriver()
            .drive(onNext: self.dismiss)
            .disposed(by: self.eventDisposeBag)
            
    }
    
    private func popViewController() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func dismiss() {
        self.dismiss(animated: true, completion: nil)
    }
}
