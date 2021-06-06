//
//  StockDetailReactor.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/06/06.
//

import RxSwift
import RxCocoa
import ReactorKit

class StockDetailReactor: Reactor {
    
    enum Action {
        case swipePage(Int)
        case tapRefresh
        case finishRefresh
    }
    
    enum Mutation {
        case selectTab(Int)
        case setLoading(Bool)
        case refresh(Int)
    }
    
    struct State {
        var currentTab: Int
        var loading: Bool = false
    }
    
    let initialState: State
    let refreshPublisher = PublishRelay<Int>()
    
    init(type: StockType) {
        switch type {
        case .domestic:
            self.initialState = State(currentTab: 0)
        case .abroad:
            self.initialState = State(currentTab: 1)
        case .coin:
            self.initialState = State(currentTab: 2)
        }
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .swipePage(let index):
            return .just(.selectTab(index))
        case .tapRefresh:
            return .concat([
                .just(.setLoading(true)),
                .just(.refresh(self.currentState.currentTab))
            ])
        case .finishRefresh:
            return .just(.setLoading(false))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .selectTab(let index):
            newState.currentTab = index
        case .setLoading(let isLoading):
            newState.loading = isLoading
        case .refresh(let currentIndex):
            self.refreshPublisher.accept(currentIndex)
        }
        
        return newState
    }
}
