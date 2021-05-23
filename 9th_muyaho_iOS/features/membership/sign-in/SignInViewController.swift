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
        membershipService: MembershipService(),
        userDefaults: UserDefaultsUtils()
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
            .map { $0.goToMainFlag }
            .filter { $0 == true }
            .map { _ in Void() }
            .bind(onNext: self.goToMain)
            .disposed(by: self.disposeBag)
        
        reactor.state
            .map { $0.goToSignUpFlag }
            .distinctUntilChanged()
            .map { _ in return (reactor.socialType, reactor.authRequest) }
            .bind(onNext: self.gpToSignUp)
            .disposed(by: self.disposeBag)
        
        reactor.state
            .map { $0.alertMessage }
            .compactMap { $0 }
            .distinctUntilChanged()
            .bind(onNext: self.showAlert(message:))
            .disposed(by: self.disposeBag)
    }
    
    private func gpToSignUp(socialType: SocialType?, authRequest: AuthRequest?) {
        guard let authRequest = authRequest else { return }
        guard let socialType = socialType else { return }
        let signUpViewController = SignUpViewController.instance(socialType: socialType, accessToken: authRequest)
        
        self.navigationController?.pushViewController(signUpViewController, animated: true)
    }
    
    private func goToMain() {
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            sceneDelegate.goToMain()
        }
    }
}
