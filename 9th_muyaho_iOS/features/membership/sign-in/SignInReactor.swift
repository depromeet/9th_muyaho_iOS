//
//  SignInReactor.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/04/28.
//

import RxSwift
import RxCocoa
import ReactorKit

class SignInReactor: Reactor, BaseReactorProtocol {
    
    var initialState = State()
    let kakaoManager: SigninManagerProtocol
    let appleManager: SigninManagerProtocol
    let membershipService: MembershipServiceProtocol
    var userDefaults: UserDefaultsUtils
    
    var authRequest: AuthRequest?
    var socialType: SocialType?
    
    enum Action {
        case tapKakaoButton
        case tapAppleButton
    }
    
    enum Mutation {
        case goToSignUp
        case goToMain
        case setAlertMessage(String)
    }
    
    struct State {
        var goToSignUpFlag: Bool = false
        var goToMainFlag: Bool = false
        var alertMessage: String?
    }
    
    
    init(
        kakaoManager: KakaoSignInManager,
        appleManager: AppleSignInManager,
        membershipService: MembershipServiceProtocol,
        userDefaults: UserDefaultsUtils
    ) {
        self.kakaoManager = kakaoManager
        self.appleManager = appleManager
        self.membershipService = membershipService
        self.userDefaults = userDefaults
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .tapKakaoButton:
            return self.kakaoManager.signIn()
                .do(onNext: { [weak self] authRequest in
                    self?.authRequest = authRequest
                    self?.socialType = .kakao
                })
                .map { (SocialType.kakao, $0) }
                .flatMap(self.membershipService.signIn)
                .do(onNext: { [weak self] in
                    self?.userDefaults.sessionId = $0.data.sessionId
                })
                .map { _ in Mutation.goToMain }
                .catchError(self.handleSignInError(error:))
        case .tapAppleButton:
            return self.appleManager.signIn()
                .do(onNext: { [weak self] authRequest in
                    self?.authRequest = authRequest
                    self?.socialType = .apple
                })
                .map { (SocialType.apple, $0) }
                .flatMap(self.membershipService.signIn)
                .do(onNext: { [weak self] in
                    self?.userDefaults.sessionId = $0.data.sessionId
                })
                .map { _ in Mutation.goToMain }
                .catchError(self.handleSignInError(error:))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .goToSignUp:
            newState.goToSignUpFlag.toggle()
        case .goToMain:
            newState.goToMainFlag.toggle()
        case .setAlertMessage(let message):
            newState.alertMessage = message
        }
        
        return newState
    }
    
    private func handleSignInError(error: Error) -> Observable<Mutation> {
        if let httpError = error as? HTTPError,
           httpError == .notFound {
            return Observable.just(Mutation.goToSignUp)
        } else {
            return self.handleDefaultError(error: error)
                .map { Mutation.setAlertMessage($0) }
        }
    }
}
