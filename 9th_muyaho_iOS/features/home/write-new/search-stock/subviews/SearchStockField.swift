//
//  SearchStockField.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/05/21.
//

import UIKit

class SearchStockField: BaseView {
    
    let containerView = UIView().then {
        $0.layer.cornerRadius = 10
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.sub_white_w2.cgColor
    }
    
    let searchImage = UIImageView().then {
        $0.image = .searchBlue
    }
    
    let textField = UITextField().then {
        let placeholderText = NSAttributedString(
            string: "stock_search_placeholder".localized,
            attributes: [.foregroundColor: UIColor.sub_black_b5 as Any]
        )
        
        $0.font = .body2_14R
        $0.textColor = .sub_white_w2
        $0.attributedPlaceholder = placeholderText
    }
    
    let deleteButton = UIButton().then {
        $0.setImage(.icDelete, for: .normal)
    }
    
    
    override func setup() {
        self.backgroundColor = .clear
        self.addSubviews(containerView, searchImage, textField, deleteButton)
    }
    
    override func bindConstraints() {
        self.containerView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview().priority(.high)
            make.bottom.equalTo(self.searchImage).offset(12)
        }
        
        self.searchImage.snp.makeConstraints { make in
            make.top.equalTo(self.containerView).offset(12)
            make.left.equalTo(self.containerView).offset(16)
            make.width.height.equalTo(24)
        }
        
        self.deleteButton.snp.makeConstraints { make in
            make.right.equalTo(self.containerView).offset(-16)
            make.centerY.equalTo(self.searchImage)
        }
        
        self.textField.snp.makeConstraints { make in
            make.left.equalTo(self.searchImage.snp.right).offset(8)
            make.centerY.equalTo(self.searchImage)
            make.right.equalTo(self.deleteButton).offset(-8)
        }
        
        self.snp.makeConstraints { make in
            make.edges.equalTo(self.containerView)
        }
    }
}
