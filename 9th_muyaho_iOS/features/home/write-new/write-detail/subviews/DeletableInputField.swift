//
//  DeletableInputField.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/05/29.
//

import UIKit
import RxSwift
import RxCocoa

class DeletableInputField: BaseView {
    
    let textfield = UITextField().then {
        $0.textColor = .sub_white_w2
        $0.font = .body1_16
        $0.returnKeyType = .done
        $0.keyboardType = .numberPad
        $0.attributedPlaceholder = NSAttributedString(
            string: "0",
            attributes: [.foregroundColor: UIColor.sub_gray_40]
        )
    }
    
    let bottomLineView = UIView().then {
        $0.backgroundColor = .sub_gray_60
    }
    
    let deleteButton = UIButton().then {
        $0.setImage(.icDelete, for: .normal)
    }
    
    
    override func setup() {
        self.backgroundColor = .clear
        self.addSubviews(textfield, bottomLineView, deleteButton)
        self.textfield.rx.text.orEmpty
            .map { $0.isEmpty }
            .asDriver(onErrorJustReturn: true)
            .drive(onNext: self.setEmpty(isEmpty:))
            .disposed(by: self.disposeBag)
        self.deleteButton.rx.tap
            .asDriver()
            .drive(onNext: self.clearField)
            .disposed(by: self.disposeBag)
    }
    
    override func bindConstraints() {
        self.textfield.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(9).priority(.high)
            make.left.equalToSuperview().priority(.high)
            make.right.equalTo(self.deleteButton.snp.left).offset(-8)
        }
        
        self.bottomLineView.snp.makeConstraints { make in
            make.left.equalTo(self.textfield)
            make.right.equalTo(self.deleteButton)
            make.top.equalTo(self.textfield.snp.bottom).offset(9)
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
        
        self.deleteButton.snp.makeConstraints { make in
            make.centerY.equalTo(self.textfield)
            make.right.equalToSuperview()
        }
        
        self.snp.makeConstraints { make in
            make.top.equalTo(self.textfield).offset(-9)
            make.left.equalTo(self.textfield)
            make.right.equalTo(self.deleteButton)
            make.bottom.equalTo(self.bottomLineView)
        }
    }
    
    private func setEmpty(isEmpty: Bool) {
        self.deleteButton.isHidden = isEmpty
        UIView.transition(
            with: self.bottomLineView,
            duration: 0.3,
            options: .curveEaseInOut
        ) { [weak self] in
            self?.bottomLineView.backgroundColor = isEmpty ? .sub_gray_60 : .primary_fade
        }
    }
    
    private func clearField() {
        self.textfield.rx.text.onNext(nil)
        self.setEmpty(isEmpty: true)
    }
}

extension Reactive where Base: DeletableInputField {
    
    var text: ControlProperty<String> {
        return base.textfield.rx.text.orEmpty
    }
}
