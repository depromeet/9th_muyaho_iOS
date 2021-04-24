//
//  File.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/04/18.
//

import UIKit

class HomeView: BaseView {
    
    let refreshButton: UIButton = {
        let button = UIButton()
        
        button.setImage(.refresh, for: .normal)
        return button
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .black
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    
    
    override func setup() {
        self.backgroundColor = .white
        self.addSubviews(refreshButton, titleLabel)
    }
    
    override func bindConstraints() {
        self.refreshButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16)
            make.top.equalTo(self.safeAreaLayoutGuide).offset(16)
        }
        
        self.titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.top.equalTo(self.refreshButton.snp.bottom).offset(24)
        }
    }
}
