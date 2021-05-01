//
//  AppleServices.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/04/29.
//

import AuthenticationServices
import RxSwift

class AppleSignInManager: NSObject, SigninManagerProtocol {
    
    let publisher: PublishSubject<AuthRequest> = PublishSubject<AuthRequest>()

    
    deinit {
        self.publisher.onCompleted()
    }
    
    func signIn() -> Observable<AuthRequest> {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        
        request.requestedScopes = [.fullName, .email]
        
        let authController = ASAuthorizationController(authorizationRequests: [request])
        
        authController.delegate = self
        authController.performRequests()
        
        return self.publisher
    }
}

extension AppleSignInManager: ASAuthorizationControllerDelegate {
    
    func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithError error: Error
    ) {
        if let authorizationError = error as? ASAuthorizationError {
            switch authorizationError.code {
            case .canceled:
                break
            case .failed, .invalidResponse, .notHandled, .unknown:
                let error = CommonError(description: authorizationError.localizedDescription)
                
                self.publisher.onError(error)
            default:
                let error = CommonError(description: error.localizedDescription)
                
                self.publisher.onError(error)
            }
        } else {
            let error = CommonError(description: "error is instance of \(error.self). not ASAuthorizationError")
            
            self.publisher.onError(error)
        }
    }
    
    func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithAuthorization authorization: ASAuthorization
    ) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential,
           let accessToken = String(data: appleIDCredential.identityToken!, encoding: .utf8) {
            self.publisher.onNext( AuthRequest(provider: .apple, token: accessToken))
        } else {
            let signInError = CommonError(description: "credential is not ASAuthorizationAppleIDCredential")
            
            self.publisher.onError(signInError)
        }
    }
}
