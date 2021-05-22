//
//  StockSearchButton.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/05/20.
//

import UIKit

class StockSearchButton: UIButton {
    
    let searchImage = UIImageView().then {
        $0.image = .searchBlue
    }
    
    let textLabel = UILabel().then {
        $0.font = .body2_14R
        $0.textColor = .sub_black_b5
        $0.text = "write_new_stock_search".localized
    }
    
    let underLineView = UIView().then {
        $0.backgroundColor = .sub_black_b5
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setup()
        self.bindConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.backgroundColor = .clear
        self.addSubviews(searchImage, textLabel, underLineView)
    }
    
    private func bindConstraints() {
        self.searchImage.snp.makeConstraints { make in
            make.top.equalToSuperview().priority(.high)
            make.left.equalTo(self.underLineView).offset(12)
            make.width.height.equalTo(24)
        }
        
        self.textLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self.searchImage)
            make.left.equalTo(self.searchImage.snp.right).offset(8)
        }
        
        self.underLineView.snp.makeConstraints { make in
            make.left.equalToSuperview().priority(.high)
            make.right.equalToSuperview().priority(.high)
            make.top.equalTo(self.searchImage.snp.bottom).offset(11)
            make.height.equalTo(1)
        }
        
        self.snp.makeConstraints { make in
            make.top.equalTo(self.searchImage).offset(-12)
            make.left.bottom.right.equalTo(self.underLineView)
        }
    }
}
