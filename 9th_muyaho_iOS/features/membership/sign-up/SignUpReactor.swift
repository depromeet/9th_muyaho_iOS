//
//  SignUpReactor.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/04/30.
//

import RxSwift
import RxCocoa
import ReactorKit

class SignUpReactor: Reactor {
    
    var initialState = State()
    let requestRequest: AuthRequest
    let membershipService: MembershipServiceProtocol
    var userDefaults: UserDefaultsUtils
    
    enum Action {
        case inputNickname(String)
        case tapSignUpButton
    }
    
    enum Mutation {
        case setNickname(String)
        case setValidationViewHidden(Bool)
        case goToMain
        case setAlertMessage(String)
    }
    
    struct State {
        var nickname = ""
        var isValidationViewHidden = true
        var isSignUpButtonEnable = false
        var goToMainFlag = false
        var alertMessage: String?
    }
    
    
    init(
        accessToken: AuthRequest,
        membershipService: MembershipServiceProtocol,
        userDefaults: UserDefaultsUtils
    ) {
        self.requestRequest = accessToken
        self.membershipService = membershipService
        self.userDefaults = userDefaults
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .inputNickname(let nickname):
            var observables = [Observable.just(Mutation.setNickname(nickname))]
            
            if !nickname.isEmpty {
                let validateObservable = self.membershipService.validateNickname(nickname: nickname)
                    .map { Mutation.setValidationViewHidden($0) }
                
                observables.append(validateObservable)
            }
            return Observable.concat(observables)
        case .tapSignUpButton:
            return self.membershipService.signUp(
                authRequest: self.requestRequest,
                name: self.currentState.nickname
            )
            .do(onNext: { [weak self] in
                self?.userDefaults.sessionId = $0.data.sessionId
            })
            .map { _ in Mutation.goToMain }
            .catchError(self.handleSignUpError(error:))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .setNickname(let nickname):
            newState.nickname = nickname
            newState.isSignUpButtonEnable = !nickname.isEmpty
        case .setValidationViewHidden(let isHidden):
            newState.isValidationViewHidden = isHidden
            newState.isSignUpButtonEnable = isHidden
        case .goToMain:
            newState.goToMainFlag.toggle()
        case .setAlertMessage(let message):
            newState.alertMessage = message
        }
        
        return newState
    }
    
    private func handleSignUpError(error: Error) -> Observable<Mutation> {
        
        return Observable.just(Mutation.setNickname(""))
    }
}
