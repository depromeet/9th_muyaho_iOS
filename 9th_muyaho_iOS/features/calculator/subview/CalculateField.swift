//
//  CalculateField.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/06/07.
//

import UIKit
import RxSwift
import RxCocoa

class CalculateField: BaseView {
    
    let containerView = UIView().then {
        $0.backgroundColor = .sub_black_b3
        $0.layer.cornerRadius = 10
    }
    
    let textField = UITextField().then {
        $0.font = .caption1_12R
        $0.textColor = .sub_white_w2
        $0.keyboardType = .decimalPad
    }
    
    
    override func setup() {
        self.addSubviews(
            self.containerView,
            self.textField
        )
        
        self.textField.rx.controlEvent(.editingDidBegin)
            .map { _ in Void() }
            .asDriver(onErrorJustReturn: ())
            .drive(onNext: self.focusIn)
            .disposed(by: self.disposeBag)
        
        self.textField.rx.controlEvent(.editingDidEnd)
            .map { _ in Void() }
            .asDriver(onErrorJustReturn: ())
            .drive(onNext: self.focusOut)
            .disposed(by: self.disposeBag)
    }
    
    override func bindConstraints() {
        self.containerView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
            make.height.equalTo(40)
        }
        
        self.textField.snp.makeConstraints { make in
            make.left.equalTo(self.containerView).offset(13)
            make.right.equalTo(self.containerView).offset(-13)
            make.top.equalTo(self.containerView).offset(11)
            make.bottom.equalTo(self.containerView).offset(-11)
        }
    }
    
    func setAttributedPlaceholder(placeholder: String) {
        let attributedString = NSMutableAttributedString(
            string: placeholder,
            attributes: [
                .foregroundColor: UIColor.sub_gray_40,
                .font: UIFont.caption1_12R!
            ])
        
        self.textField.attributedPlaceholder = attributedString
    }
    
    private func focusOut() {
        self.containerView.layer.borderWidth = 0
        self.containerView.layer.borderColor = UIColor.primary_fade.cgColor
    }
    
    private func focusIn() {
        self.containerView.layer.borderWidth = 1
        self.containerView.layer.borderColor = UIColor.primary_fade.cgColor
    }
}

extension Reactive where Base: CalculateField {
    
    var text: ControlProperty<String?> {
        return base.textField.rx.text
    }
}
