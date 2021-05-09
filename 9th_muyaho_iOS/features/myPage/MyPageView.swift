//
//  MyPageView.swift
//  9th_muyaho_iOS
//
//  Created by 이현호 on 2021/05/09.
//

import UIKit

final class MyPageView: BaseView {
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(named: "ic_refresh")
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .black
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    
    private let illustImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(named: "ic_refresh")
        return imageView
    }()
    
    private let logoutButton: UIButton = {
        let button = UIButton()
        button.setTitle("로그아웃", for: .normal)
        button.layer.cornerRadius = 8
        button.setTitleColor(.primary_default, for: .normal)
        button.backgroundColor = .white
        return button
    }()
    
    private let withdrawalButton: UIButton = {
        let button = UIButton()
        button.setTitle("회원탈퇴", for: .normal)
        return button
    }()
    
    override func setup() {
        backgroundColor = .primary_default
        addSubviews(logoImageView,
                    titleLabel,
                    illustImageView,
                    logoutButton,
                    withdrawalButton)
    }
    
    override func bindConstraints() {
        
        logoutButton.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.left.right.equalToSuperview().inset(20)
            make.bottom.equalTo(withdrawalButton.snp.top).offset(-21)
        }
        
        #warning("탭바 높이 계산해서 넣기")
        withdrawalButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-46-80)
        }
    }
}
