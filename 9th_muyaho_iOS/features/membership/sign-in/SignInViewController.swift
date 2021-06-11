//
//  SignInViewController.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/04/28.
//

import UIKit
import ReactorKit
import AuthenticationServices
import KakaoSDKUser
import KakaoSDKAuth
import KakaoSDKCommon

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
    
    
    override func loadView() {
        self.view = signInView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.reactor = self.signinReactor
        self.signInView.startAnimation()
    }
    
    override func bindEvent() {
        self.signInView.kakaoButton.rx.tap
            .asDriver()
            .drive(onNext: self.signInKakao)
            .disposed(by: self.eventDisposeBag)
        
        self.signInView.appleButton.rx.tap
            .asDriver()
            .drive(onNext: self.signInApple)
            .disposed(by: self.eventDisposeBag)
        
        self.signinReactor.goToSignUpPublisher
            .asDriver(onErrorJustReturn: nil)
            .drive(onNext: self.gpToSignUp)
            .disposed(by: self.eventDisposeBag)
        
        self.signinReactor.goToMainPublisher
            .asDriver(onErrorJustReturn: ())
            .drive(onNext: self.goToMain)
            .disposed(by: self.eventDisposeBag)
    }
    
    func bind(reactor: SignInReactor) {
        reactor.state
            .map { $0.alertMessage }
            .compactMap { $0 }
            .distinctUntilChanged()
            .bind(onNext: self.showAlert(message:))
            .disposed(by: self.disposeBag)
    }
    
    private func gpToSignUp(authRequest: AuthRequest?) {
        guard let authRequest = authRequest else { return }
        let signUpViewController = SignUpViewController.instance(socialType: authRequest.provider, accessToken: authRequest)
        
        self.navigationController?.pushViewController(signUpViewController, animated: true)
    }
    
    private func goToMain() {
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            sceneDelegate.goToMain()
        }
    }
    
    private func signInKakao() {
        if UserApi.isKakaoTalkLoginAvailable() {
            self.signInWithKakaoTalk()
        } else {
            self.signInWithKakaoAccount()
        }
    }
    
    private func signInWithKakaoTalk() {
        UserApi.shared.rx.loginWithKakaoTalk()
            .subscribe { authToken in
                let accessToken = AuthRequest(provider: .kakao, token: authToken.accessToken)
                
                self.signinReactor.action.onNext(.signIn(accessToken))
            } onError: { error in
                if let sdkError = error as? SdkError {
                    if sdkError.isClientFailed {
                        switch sdkError.getClientError().reason {
                        case .Cancelled:
                            break
                        default:
                            let errorMessage = sdkError.getApiError().info?.msg ?? ""
                            
                            self.showAlert(message: errorMessage)
                        }
                    }
                } else {
                    self.showAlert(message: "error is not SdkError. (\(error.self))")
                }
            }.disposed(by: self.disposeBag)
    }
    
    private func signInWithKakaoAccount() {
        UserApi.shared.rx.loginWithKakaoAccount()
            .subscribe { authToken in
                let accessToken = AuthRequest(provider: .kakao, token: authToken.accessToken)
                
                self.signinReactor.action.onNext(.signIn(accessToken))
            } onError: { error in
                if let sdkError = error as? SdkError {
                    if sdkError.isClientFailed {
                        switch sdkError.getClientError().reason {
                        case .Cancelled:
                            break
                        default:
                            let errorMessage = sdkError.getApiError().info?.msg ?? ""
                            
                            self.showAlert(message: errorMessage)
                        }
                    }
                } else {
                    self.showAlert(message: "error is not SdkError. (\(error.self))")
                }
            }
            .disposed(by: self.disposeBag)
    }
    
    private func signInApple() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        
        request.requestedScopes = [.fullName, .email]
        
        let authController = ASAuthorizationController(authorizationRequests: [request])
        
        authController.delegate = self
        authController.performRequests()
    }
}

extension SignInViewController: ASAuthorizationControllerDelegate {
    
    func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithError error: Error
    ) {
        if let authorizationError = error as? ASAuthorizationError {
            switch authorizationError.code {
            case .canceled:
                break
            case .failed, .invalidResponse, .notHandled, .unknown:
                self.showAlert(message: authorizationError.localizedDescription)
            default:
                self.showAlert(message: authorizationError.localizedDescription)
            }
        } else {
            self.showAlert(message: "error is instance of \(error.self). not ASAuthorizationError")
        }
    }
    
    func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithAuthorization authorization: ASAuthorization
    ) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential,
           let accessToken = String(data: appleIDCredential.identityToken!, encoding: .utf8) {
            let authRequest = AuthRequest(provider: .apple, token: accessToken)
            self.signinReactor.action.onNext(.signIn(authRequest))
        } else {
            self.showAlert(message: "credential is not ASAuthorizationAppleIDCredential")
        }
    }
}
