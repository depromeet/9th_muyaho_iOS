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
    let membershipService: MembershipServiceProtocol
    
    var authRequest: AuthRequest?
    
    enum Action {
        case tapKakaoButton
        case tapAppleButton
    }
    
    enum Mutation {
        case setSessionId(String)
        case goSignUp
        case showAlert(String)
    }
    
    struct State {
        var sessionId: String?
        var signUpFlag: Bool = false
        var alertMessage: String?
    }
    
    
    init(
        kakaoManager: KakaoSignInManager,
        appleManager: AppleSignInManager,
        membershipService: MembershipServiceProtocol
    ) {
        self.kakaoManager = kakaoManager
        self.appleManager = appleManager
        self.membershipService = membershipService
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .tapKakaoButton:
            return self.kakaoManager.signIn()
                .do(onNext: { [weak self] authRequest in
                    self?.authRequest = authRequest
                })
                .flatMap { self.membershipService.signIn(authRequest: $0) }
                .map { Mutation.setSessionId($0.data.sessionId) }
                .catchError(self.handleSignInError(error:))
        case .tapAppleButton:
            return self.appleManager.signIn()
                .do(onNext: { [weak self] authRequest in
                    self?.authRequest = authRequest
                })
                .flatMap { self.membershipService.signIn(authRequest: $0) }
                .map { Mutation.setSessionId($0.data.sessionId) }
                .catchError(self.handleSignInError(error:))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .setSessionId(let sessionId):
            newState.sessionId = sessionId
        case .goSignUp:
            newState.signUpFlag.toggle()
        case .showAlert(let message):
            newState.alertMessage = message
        }
        
        return newState
    }
    
    private func handleSignInError(error: Error) -> Observable<Mutation> {
        if let httpError = error as? HTTPError {
            switch httpError {
            case.notFound:
                return Observable.just(Mutation.goSignUp)
            default:
                return Observable.just(Mutation.showAlert("HTTP status code: \(httpError.rawValue)"))
            }
        } else if let commonError = error as? CommonError {
            return Observable.just(Mutation.showAlert(commonError.message))
        } else {
            return Observable.just(Mutation.showAlert(error.localizedDescription))
        }
    }
}
