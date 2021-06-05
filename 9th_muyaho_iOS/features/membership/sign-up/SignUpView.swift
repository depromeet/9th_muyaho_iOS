//
//  SignUpView.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/04/29.
//

import UIKit

class SignUpView: BaseView {
    
    let tapBackground = UITapGestureRecognizer()
    
    let backButton = UIButton().then {
        $0.setImage(.arrowLeft24, for: .normal)
    }
    
    let logoImage = UIImageView().then {
        $0.image = .imgLogo
    }
    
    let titleLabel = UILabel().then {
        $0.font = .h3_30B
        $0.textColor = .sub_white_w2
        $0.numberOfLines = 0
        $0.text = "sign_up_title".localized
    }
    
    let descriptionLabel = UILabel().then {
        $0.font = .caption1_12B
        $0.textColor = .sub_white_w2
        $0.text = "sign_up_description".localized
    }
    
    let nicknameField = UITextField().then {
        $0.textColor = .sub_white_w2
        $0.font = .subtitle2_18
        $0.returnKeyType = .done
        $0.attributedPlaceholder = NSAttributedString(
            string: "sign_up_nickname_placeholder".localized,
            attributes: [.foregroundColor: UIColor.sub_white_w2.withAlphaComponent(0.6)]
        )
    }
    
    let alreadyExistedNicknameView = AlreadyExistedNicknameView().then {
        $0.isHidden = true
    }
    
    let dividorView = UIView()
    
    let signUpButton = LargeButton(theme: .white).then {
        $0.setTitle("sign_up_button".localized, for: .normal)
    }
    
    
    override func setup() {
        self.backgroundColor = .primary_default
        self.addGestureRecognizer(self.tapBackground)
        self.nicknameField.delegate = self
        self.addSubviews(
            backButton, logoImage, titleLabel, descriptionLabel, nicknameField,
            alreadyExistedNicknameView, dividorView, signUpButton
        )
    }
    
    override func bindConstraints() {
        self.backButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(self.safeAreaLayoutGuide).offset(9)
        }
        
        self.logoImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(self.backButton)
        }
        
        self.titleLabel.snp.makeConstraints { make in
            make.left.equalTo(self.backButton)
            make.top.equalTo(self.backButton.snp.bottom).offset(32)
        }
        
        self.descriptionLabel.snp.makeConstraints { make in
            make.left.equalTo(self.backButton)
            make.top.equalTo(self.titleLabel.snp.bottom).offset(40)
        }
        
        self.nicknameField.snp.makeConstraints { make in
            make.left.equalTo(self.backButton)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(self.descriptionLabel.snp.bottom).offset(24)
        }
        
        self.alreadyExistedNicknameView.snp.makeConstraints { make in
            make.centerY.equalTo(self.nicknameField)
            make.right.equalTo(self.dividorView)
        }
        
        self.dividorView.snp.makeConstraints { make in
            make.left.equalTo(self.backButton)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(self.nicknameField.snp.bottom).offset(12)
            make.height.equalTo(2)
        }
        
        self.signUpButton.snp.makeConstraints { make in
            make.left.equalTo(self.backButton)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalTo(self.safeAreaLayoutGuide).offset(-29)
        }
    }
    
    func hideKeyboard() {
        self.endEditing(true)
    }
    
    func setDividorColor(isNicknameNotEmpty: Bool) {
        UIView.transition(with: self.dividorView, duration: 0.3, options: .curveEaseInOut) { [weak self] in
            self?.dividorView.backgroundColor = isNicknameNotEmpty ? .sub_white_w2 : UIColor(r: 177, g: 167, b: 255)
        }
    }
}

extension SignUpView: UITextFieldDelegate {
    
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.count + string.count - range.length
        
        return newLength <= 5
    }
}
