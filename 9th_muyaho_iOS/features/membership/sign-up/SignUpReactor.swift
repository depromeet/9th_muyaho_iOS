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
    
    enum Action {
        case inputNickname(String)
        case tapSignUpButton
    }
    
    enum Mutation {
        case setNickname(String)
        case setValidationViewHidden(Bool)
        case setSessionId(String)
    }
    
    struct State {
        var nickname = ""
        var isValidationViewHidden = true
        var isSignUpButtonEnable = false
        var sessionId: String?
    }
    
    
    init(
        accessToken: AuthRequest,
        membershipService: MembershipServiceProtocol
    ) {
        self.requestRequest = accessToken
        self.membershipService = membershipService
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
            let nickname = self.currentState.nickname
            
            return self.membershipService.signUp(authRequest: self.requestRequest, name: nickname)
                .map { Mutation.setSessionId($0.data.sessionId) }
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
        case .setSessionId(let sessionId):
            newState.sessionId = sessionId
        }
        
        return newState
    }
    
    private func handleSignUpError(error: Error) -> Observable<Mutation> {
        
        return Observable.just(Mutation.setSessionId(""))
    }
}
