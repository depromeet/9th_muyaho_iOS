//
//  WriteMenuView.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/05/19.
//

import UIKit

class WriteMenuView: BaseView {
    
    let tapBackground = UITapGestureRecognizer()
    
    let dimmedView = UIView(frame: UIScreen.main.bounds).then {
        $0.backgroundColor = .sub_black_b1
        $0.alpha = 0.8
    }
    
    let cancelButton = UIButton().then {
        $0.setImage(.icCancelWrite, for: .normal)
    }
    
    let modifyButton = UIButton().then {
        $0.setImage(.icWriteModify, for: .normal)
        $0.setTitle("write_menu_modify".localized, for: .normal)
        $0.setTitleColor(.sub_white_w2, for: .normal)
        $0.titleLabel?.font = .body1_16
        $0.semanticContentAttribute = .forceRightToLeft
        $0.titleEdgeInsets = .init(top: 0, left: -16, bottom: 0, right: 16)
        $0.contentEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 8)
        $0.alpha = 0
    }
    
    let newButton = UIButton().then {
        $0.setImage(.icWriteNew, for: .normal)
        $0.setTitle("write_menu_new".localized, for: .normal)
        $0.setTitleColor(.sub_white_w2, for: .normal)
        $0.titleLabel?.font = .body1_16
        $0.semanticContentAttribute = .forceRightToLeft
        $0.titleEdgeInsets = .init(top: 0, left: -16, bottom: 0, right: 16)
        $0.contentEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 8)
        $0.alpha = 0
    }
    
    
    override func setup() {
        self.backgroundColor = .clear
        self.dimmedView.addGestureRecognizer(self.tapBackground)
        self.addSubviews(dimmedView, modifyButton, newButton, cancelButton)
    }
    
    override func bindConstraints() {
        self.dimmedView.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
        
        self.cancelButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.safeAreaLayoutGuide).offset(-85)
            make.right.equalToSuperview().offset(-16)
        }
        
        self.modifyButton.snp.makeConstraints { make in
            make.right.equalTo(self.cancelButton)
            make.top.equalTo(self.cancelButton)
        }
        
        self.newButton.snp.makeConstraints { make in
            make.right.equalTo(self.cancelButton)
            make.top.equalTo(self.cancelButton)
        }
    }
    
    func startPresentAnimation() {
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.modifyButton.transform = .init(translationX: 0, y: -62)
            self?.modifyButton.alpha = 1
            self?.newButton.transform = .init(translationX: 0, y: -120)
            self?.newButton.alpha = 1
        }
    }
    
    func startDismissAnimation(completion: @escaping ((Bool) -> Void)) {
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            self?.modifyButton.transform = .identity
            self?.modifyButton.alpha = 0
            self?.newButton.transform = .identity
            self?.newButton.alpha = 0
        }, completion: completion)
    }
}
