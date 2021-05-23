//
//  KakaoServices.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/04/29.
//

import RxKakaoSDKUser
import KakaoSDKUser
import KakaoSDKAuth
import KakaoSDKCommon
import RxSwift

class KakaoSignInManager: SigninManagerProtocol {
    
    private let disposeBag = DisposeBag()
    let publisher = PublishSubject<AuthRequest>()
    
    
    deinit {
        self.publisher.onCompleted()
    }
    
    func signIn() -> Observable<AuthRequest> {
        if UserApi.isKakaoTalkLoginAvailable() {
            self.signInWithKakaoTalk()
        } else {
            self.signInWithKakaoAccount()
        }
        return self.publisher
    }
    
    private func signInWithKakaoTalk() {
        UserApi.shared.rx.loginWithKakaoTalk()
            .subscribe { authToken in
                let accessToken = AuthRequest(provider: .kakao, token: authToken.accessToken)
                
                self.publisher.onNext(accessToken)
            } onError: { error in
                if let sdkError = error as? SdkError {
                    if sdkError.isClientFailed {
                        switch sdkError.getClientError().reason {
                        case .Cancelled:
                            break
                        default:
                            let errorMessage = sdkError.getApiError().info?.msg ?? ""
                            let error = CommonError.custom(errorMessage)
                            
                            self.publisher.onError(error)
                        }
                    }
                } else {
                    let signInError = CommonError.custom("error is not SdkError. (\(error.self))")
                    
                    self.publisher.onError(signInError)
                }
            }.disposed(by: self.disposeBag)
    }
    
    private func signInWithKakaoAccount() {
        UserApi.shared.rx.loginWithKakaoAccount()
            .subscribe { authToken in
                let accessToken = AuthRequest(provider: .kakao, token: authToken.accessToken)
                
                self.publisher.onNext(accessToken)
            } onError: { error in
                self.publisher.onError(error)
            }
            .disposed(by: self.disposeBag)
    }
}
