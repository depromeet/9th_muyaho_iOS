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
    let accessToken: AccessToken
    
    enum Action {
        case inputNickname(String)
        case tapSignUpButton
    }
    
    enum Mutation {
        case setNickname(String)
        case setSignUpButtonEnable(Bool)
    }
    
    struct State {
        var nickname = ""
        var isSignUpButtonEnable = false
    }
    
    
    init(accessToken: AccessToken) {
        self.accessToken = accessToken
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .inputNickname(let nickname):
            return Observable.concat([
                Observable.just(Mutation.setNickname(nickname)),
                Observable.just(Mutation.setSignUpButtonEnable(!nickname.isEmpty))
            ])
        default:
            return Observable.just(Mutation.setNickname(""))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .setNickname(let nickname):
            newState.nickname = nickname
        case .setSignUpButtonEnable(let isEnable):
            newState.isSignUpButtonEnable = isEnable
        }
        
        return newState
    }
}
