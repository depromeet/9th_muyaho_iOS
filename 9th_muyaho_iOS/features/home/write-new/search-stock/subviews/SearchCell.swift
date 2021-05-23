//
//  SearchCell.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/05/23.
//

import UIKit

class SearchCell: BaseTableViewCell {
    
    enum CellType {
        case normal
        case deleteable
    }
    
    let titleLabel = UILabel().then {
        $0.font = .body2_14R
        $0.textColor = .sub_white_w1
    }
    
    let deleteButton = UIButton().then {
        $0.setImage(.icDelete, for: .normal)
    }
    
    let dividorView = UIView().then {
        $0.backgroundColor = .sub_black_b5
    }
    
    
    override func setup() {
        self.selectionStyle = .none
        self.addSubviews(titleLabel, deleteButton, dividorView)
    }
    
    override func bindConstraints() {
        self.dividorView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
        
        self.titleLabel.snp.makeConstraints { make in
            make.left.equalTo(self.dividorView)
            make.top.equalToSuperview().offset(16)
        }
        
        self.deleteButton.snp.makeConstraints { make in
            make.centerY.equalTo(self.titleLabel)
            make.right.equalTo(self.dividorView).offset(-4)
        }
    }
}
