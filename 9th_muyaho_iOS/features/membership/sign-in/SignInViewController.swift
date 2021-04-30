//
//  SignInViewController.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/04/28.
//

import UIKit
import ReactorKit
import AuthenticationServices

class SignInViewController: BaseViewController, View {
    
    private let signInView = SignInView()
    private let signinReactor = SignInReactor(
        kakaoManager: KakaoSignInManager(),
        appleManager: AppleSignInManager()
    )
    
    
    static func instance() -> SignInViewController {
        return SignInViewController(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.reactor = self.signinReactor
    }
    
    override func setupView() {
        self.view.addSubviews(signInView)
        self.signInView.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
    }
    
    func bind(reactor: SignInReactor) {
        // Bind action
        self.signInView.kakaoButton.rx.tap
            .map { SignInReactor.Action.tapKakaoButton }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        self.signInView.appleButton.rx.tap
            .map { SignInReactor.Action.tapAppleButton }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        // Bind State
        reactor.state
            .map { $0.accessToken }
            .compactMap { $0 }
            .distinctUntilChanged()
            .bind(onNext: self.pushSignUpViewController(accessToken:))
            .disposed(by: self.disposeBag)
        
        reactor.state
            .map { $0.alertMessage }
            .compactMap { $0 }
            .distinctUntilChanged()
            .bind { message in
                print(message)
            }
            .disposed(by: self.disposeBag)
    }
    
    private func pushSignUpViewController(accessToken: AccessToken) {
        let signUpViewController = SignUpViewController.instance(accessToken: accessToken)
        
        self.navigationController?.pushViewController(signUpViewController, animated: true)
    }
}
