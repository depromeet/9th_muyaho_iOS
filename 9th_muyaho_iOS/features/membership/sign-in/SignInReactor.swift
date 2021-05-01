//
//  SignInReactor.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/04/28.
//

import RxSwift
import RxCocoa
import ReactorKit

class SignInReactor: Reactor {
    
    var initialState = State()
    let kakaoManager: SigninManagerProtocol
    let appleManager: SigninManagerProtocol
    
    enum Action {
        case tapKakaoButton
        case tapAppleButton
    }
    
    enum Mutation {
        case setAuthRequest(AuthRequest)
        case showAlert(String)
    }
    
    struct State {
        var authRequest: AuthRequest?
        var alertMessage: String?
    }
    
    
    init(kakaoManager: KakaoSignInManager, appleManager: AppleSignInManager) {
        self.kakaoManager = kakaoManager
        self.appleManager = appleManager
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .tapKakaoButton:
            return self.kakaoManager.signIn()
                .map { Mutation.setAuthRequest($0) }
                .catchError(self.handleSignInError(error:))
        case .tapAppleButton:
            return self.appleManager.signIn()
                .map { Mutation.setAuthRequest($0) }
                .catchError(self.handleSignInError(error:))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .setAuthRequest(let authToken):
            newState.authRequest = authToken
        case .showAlert(let message):
            newState.alertMessage = message
        }
        
        return newState
    }
    
    private func handleSignInError(error: Error) -> Observable<Mutation> {
        if let commonError = error as? CommonError {
            return Observable.just(Mutation.showAlert(commonError.description))
        } else {
            return Observable.just(Mutation.showAlert(error.localizedDescription))
        }
    }
}
