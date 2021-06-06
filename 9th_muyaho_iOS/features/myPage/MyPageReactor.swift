//
//  MyPageReactor.swift
//  9th_muyaho_iOS
//
//  Created by 이현호 on 2021/05/09.
//

import ReactorKit
import RxCocoa

class MyPageReactor: Reactor, BaseReactorProtocol {

    enum Action {
        case viewDidLoad
        case tapSignout
        case tapWithdrawal
    }
    
    enum Mutation {
        case setUser(MemberInfoResponse)
        case goToSignIn
        case setAlertMessage(String)
    }
    
    struct State {
        var member: MemberInfoResponse = MemberInfoResponse()
        var alertMessage: String?
    }
    
    let initialState = State()
    let userDefaults: UserDefaultsUtils
    let memberService: MembershipServiceProtocol
    let goToSignInPublisher = PublishRelay<Void>()
    
    init(
        userDefaults: UserDefaultsUtils,
        memberService: MembershipServiceProtocol
    ) {
        self.userDefaults = userDefaults
        self.memberService = memberService
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewDidLoad:
            return self.memberService.fetchMemberInfo()
                .map { Mutation.setUser($0.data) }
                .catchError(self.handleError(error:))
        case .tapSignout:
            return .empty()
        case .tapWithdrawal:
            return .empty()
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .setUser(let memberResponse):
            newState.member = memberResponse
        case .goToSignIn:
            self.goToSignInPublisher.accept(())
        case .setAlertMessage(let message):
            newState.alertMessage = message
        }
        return newState
    }
    
    private func handleError(error: Error) -> Observable<Mutation> {
        return self.handleDefaultError(error: error)
            .map { Mutation.setAlertMessage($0) }
    }
}
