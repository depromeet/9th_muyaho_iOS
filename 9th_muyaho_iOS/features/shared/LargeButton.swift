//
//  LargeButton.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/04/30.
//

import UIKit
import RxSwift
import RxCocoa

class LargeButton: UIButton {
    
    let buttonTheme: ButtonTheme
    
    enum ButtonTheme {
        case purple
        case white
    }
    
    
    init(theme: ButtonTheme) {
        self.buttonTheme = theme
        super.init(frame: .zero)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.titleLabel?.font = .body2_14B
        self.layer.cornerRadius = 8
        self.contentEdgeInsets = UIEdgeInsets(top: 14, left: 0, bottom: 14, right: 0)
        
        if self.buttonTheme == .white {
            self.setTitleColor(.primary_fade, for: .normal)
            self.setTitleColor(.sub_white_w1, for: .disabled)
        } else {
            self.setTitleColor(.sub_white_w2, for: .normal)
            self.setTitleColor(.sub_gray_20, for: .disabled)
        }
        
        self.layer.shadowColor = UIColor.primary_default.cgColor
        self.layer.shadowOffset = CGSize(width: 4, height: 4)
        self.layer.shadowOpacity = 0
    }
    
    func setBackgroundColor(theme: ButtonTheme) {
        UIView.transition(with: self, duration: 0.3, options: .curveEaseInOut) { [weak self] in
            guard let self = self else { return }
            if theme == .white {
                self.backgroundColor = self.isEnabled ? .sub_white_w2 : UIColor.sub_white_w2.withAlphaComponent(0.4)
            } else {
                self.backgroundColor = self.isEnabled ? .primary_default : UIColor(r: 45, g: 36, b: 125)
                self.layer.shadowOpacity = self.isEnabled ? 0.4 : 0
            }
        }
    }
}

extension Reactive where Base: LargeButton {
    
    var isEnabled: Binder<Bool> {
        return Binder(self.base) { view, isEnable in
            base.isEnabled = isEnable
            base.setBackgroundColor(theme: base.buttonTheme)
        }
    }
}
