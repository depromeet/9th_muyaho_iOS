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
        appleManager: AppleSignInManager(),
        membershipService: MembershipService()
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
            .map { $0.sessionId }
            .compactMap { $0 }
            .distinctUntilChanged()
            .bind { sessionId in
                // TODO: 로그인 성공해서 홈 화면으로 이동
                print("sessionId: \(sessionId)")
            }
            .disposed(by: self.disposeBag)
        
        reactor.state
            .map { $0.goToSignUpFlag }
            .distinctUntilChanged()
            .map { _ in reactor.authRequest }
            .bind(onNext: self.pushSignUpViewController(authRequest:))
            .disposed(by: self.disposeBag)
        
        reactor.state
            .map { $0.alertMessage }
            .compactMap { $0 }
            .distinctUntilChanged()
            .bind { message in
                // TODO: Alert 띄우기
                print(message)
            }
            .disposed(by: self.disposeBag)
    }
    
    private func pushSignUpViewController(authRequest: AuthRequest?) {
        guard let authRequest = authRequest else { return }
        let signUpViewController = SignUpViewController.instance(accessToken: authRequest)
        
        self.navigationController?.pushViewController(signUpViewController, animated: true)
    }
}
