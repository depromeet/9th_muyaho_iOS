//
//  WriteMenuViewController.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/05/19.
//

import RxSwift
import RxCocoa
import UIKit

protocol WriteMenuDelegate: AnyObject {
    func onTapNew()
    func onTapModify()
}

class WriteMenuViewController: BaseViewController {
    
    weak var delegate: WriteMenuDelegate?
    private let writeMenuView = WriteMenuView()
    private let impactGenerator = UIImpactFeedbackGenerator(style: .medium)
    
    
    static func instance() -> WriteMenuViewController {
        return WriteMenuViewController(nibName: nil, bundle: nil).then {
            $0.modalPresentationStyle = .overCurrentContext
            $0.modalTransitionStyle = .crossDissolve
        }
    }
    
    override func setupView() {
        self.view.addSubview(self.writeMenuView)
        self.writeMenuView.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
    }
    
    override func bindEvent() {
        self.writeMenuView.cancelButton.rx.tap
            .observeOn(MainScheduler.instance)
            .bind(onNext: self.dismiss)
            .disposed(by: self.eventDisposeBag)
        
        self.writeMenuView.tapBackground.rx.event
            .map { _ in Void() }
            .bind(onNext: self.dismiss)
            .disposed(by: self.eventDisposeBag)
        
        self.writeMenuView.newButton.rx.tap
            .observeOn(MainScheduler.instance)
            .bind(onNext: self.showWriteNew)
            .disposed(by: self.eventDisposeBag)
        
        self.writeMenuView.modifyButton.rx.tap
            .observeOn(MainScheduler.instance)
            .bind(onNext: self.showModify)
            .disposed(by: self.eventDisposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.impactGenerator.impactOccurred()
        self.writeMenuView.startPresentAnimation()
    }
    
    private func dismiss() {
        self.impactGenerator.impactOccurred()
        self.writeMenuView.startDismissAnimation { [weak self] _ in
            self?.dismiss(animated: true, completion: nil)
        }
    }
    
    private func dismiss(completion: @escaping (() -> Void)) {
        self.impactGenerator.impactOccurred()
        self.writeMenuView.startDismissAnimation { [weak self] _ in
            self?.dismiss(animated: true, completion: completion)
        }
    }
    
    private func showWriteNew() {
        self.dismiss { [weak self] in
            self?.delegate?.onTapNew()
        }
    }
    
    private func showModify(){
        self.dismiss { [weak self] in
            self?.delegate?.onTapModify()
        }
    }
}
