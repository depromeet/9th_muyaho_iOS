//
//  StockTypesButton.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/05/20.
//

import UIKit

class StockTypeButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isSelected: Bool {
        didSet {
            if self.isSelected {
                self.layer.borderColor = UIColor.sub_white_w2.cgColor
            } else {
                self.layer.borderColor = UIColor.sub_black_b5.cgColor
            }
        }
    }
    
    private func setup() {
        self.titleLabel?.font = .body2_14R
        self.setTitleColor(.sub_white_w2, for: .selected)
        self.setTitleColor(.sub_black_b5, for: .normal)
        self.contentEdgeInsets = .init(top: 10, left: 25, bottom: 10, right: 25)
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.sub_black_b5.cgColor
    }
}
