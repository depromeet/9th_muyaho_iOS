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
        case tapDomestic
        case tapAbroad
        case tapCoin
    }
    
    enum Mutation {
        case selectTab(Int)
    }
    
    struct State {
        var currentTab: Int
    }
    
    let initialState: State
    
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
        case .tapDomestic:
            return .just(.selectTab(0))
        case .tapAbroad:
            return .just(.selectTab(1))
        case .tapCoin:
            return .just(.selectTab(2))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .selectTab(let index):
            newState.currentTab = index
        }
        
        return newState
    }
}
