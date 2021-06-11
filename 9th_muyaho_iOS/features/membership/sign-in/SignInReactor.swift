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
    
    enum Action {
        case signIn(AuthRequest)
    }
    
    enum Mutation {
        case goToSignUp
        case goToMain
        case setAlertMessage(String)
    }
    
    struct State {
        var alertMessage: String?
    }
    
    let goToSignUpPublisher = PublishRelay<AuthRequest?>()
    let goToMainPublisher = PublishRelay<Void>()
    
    
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
        case .signIn(let authRequest):
            self.authRequest = authRequest
            return self.membershipService.signIn(
                socialType: authRequest.provider, authRequest: authRequest)
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
            self.goToSignUpPublisher.accept(self.authRequest)
        case .goToMain:
            self.goToMainPublisher.accept(())
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
