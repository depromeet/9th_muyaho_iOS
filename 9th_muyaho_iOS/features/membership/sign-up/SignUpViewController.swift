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
    
    
    init(accessToken: AuthRequest) {
        self.signUpReactor = SignUpReactor(accessToken: accessToken, membershipService: MembershipService())
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func instance(accessToken: AuthRequest) -> SignUpViewController {
        return SignUpViewController(accessToken: accessToken)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.reactor = self.signUpReactor
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
        self.signUpReactor.state
            .map { $0.isSignUpButtonEnable }
            .distinctUntilChanged()
            .do(onNext: self.signUpView.setDividorColor(isNicknameNotEmpty:))
            .bind(to: self.signUpView.signUpButton.rx.isEnabled)
            .disposed(by: self.disposeBag)
        
        self.signUpReactor.state
            .map { $0.isValidationViewHidden }
            .distinctUntilChanged()
            .bind(to: self.signUpView.alreadyExistedNicknameView.rx.isHidden)
            .disposed(by: self.disposeBag)
        
        self.signUpReactor.state
            .compactMap { $0.sessionId }
            .distinctUntilChanged()
            .bind { sessionId in
                print("sessionId: \(sessionId)")
            }
            .disposed(by: self.disposeBag)
    }
    
    private func popup() {
        self.navigationController?.popViewController(animated: true)
    }
}
