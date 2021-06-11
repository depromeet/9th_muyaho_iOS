//
//  SignUpViewController.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/04/29.
//

import UIKit
import RxSwift
import ReactorKit

class SignUpViewController: BaseViewController, View {
    
    private let signUpView = SignUpView()
    private let signUpReactor: SignUpReactor
    
    
    init(socialType: SocialType, accessToken: AuthRequest) {
        self.signUpReactor = SignUpReactor(
            socialType: socialType,
            accessToken: accessToken,
            membershipService: MembershipService(),
            userDefaults: UserDefaultsUtils()
        )
        super.init(nibName: nil, bundle: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func instance(socialType: SocialType, accessToken: AuthRequest) -> SignUpViewController {
        return SignUpViewController(socialType: socialType, accessToken: accessToken)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.reactor = self.signUpReactor
        self.setupKeyboardNotification()
    }
    
    override func setupView() {
        self.view.addSubviews(signUpView)
        self.signUpView.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
    }
    
    override func bindEvent() {
        self.signUpView.tapBackground.rx.event
            .map { _ in Void() }
            .bind(onNext: self.signUpView.hideKeyboard)
            .disposed(by: self.eventDisposeBag)
        
        self.signUpView.backButton.rx.tap
            .observeOn(MainScheduler.instance)
            .bind(onNext: self.popup)
            .disposed(by: self.eventDisposeBag)
    }
    
    func bind(reactor: SignUpReactor) {
        // Bind Action
        self.signUpView.nicknameField.rx.text.orEmpty
            .distinctUntilChanged()
            .map { SignUpReactor.Action.inputNickname($0) }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        self.signUpView.signUpButton.rx.tap
            .map { SignUpReactor.Action.tapSignUpButton }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        // Bind State
        reactor.state
            .map { $0.isSignUpButtonEnable }
            .distinctUntilChanged()
            .do(onNext: self.signUpView.setDividorColor(isNicknameNotEmpty:))
            .bind(to: self.signUpView.signUpButton.rx.isEnabled)
            .disposed(by: self.disposeBag)
        
        reactor.state
            .map { $0.isValidationViewHidden }
            .distinctUntilChanged()
            .bind(to: self.signUpView.alreadyExistedNicknameView.rx.isHidden)
            .disposed(by: self.disposeBag)
        
        reactor.state
            .map { $0.goToMainFlag }
            .filter { $0 == true }
            .map { _ in Void() }
            .bind(onNext: self.goToMain)
            .disposed(by: self.disposeBag)
        
        reactor.state
            .map { $0.alertMessage }
            .compactMap { $0 }
            .distinctUntilChanged()
            .bind(onNext: self.showAlert(message:))
            .disposed(by: self.disposeBag)
    }
    
    private func popup() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func goToMain() {
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            sceneDelegate.goToMain()
        }
    }
    
    private func setupKeyboardNotification() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo as? [String: Any] else { return }
        guard let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardScreenEndFrame = keyboardFrame.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        let bottomInset = UIApplication.shared.windows[0].safeAreaInsets.top
        
        self.signUpView.signUpButton.transform = .init(
            translationX: 0,
            y: -keyboardViewEndFrame.height + bottomInset
        )
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        self.signUpView.signUpButton.transform = .identity
    }
}
