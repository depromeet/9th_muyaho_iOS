//
//  WriteNewStockTypeReactor.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/05/22.
//

import RxSwift
import RxCocoa
import ReactorKit

class WriteNewStockTypeReactor: Reactor {
    
    enum Action {
        case tapStockType(StockType)
    }
    
    enum Mutation {
        case setStockType(StockType)
    }
    
    struct State {
        var stockType: StockType = .domestic
    }
    
    let initialState = State()
    
    
    init() {
        
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .tapStockType(let stockType):
            return .just(.setStockType(stockType))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .setStockType(let stockType):
            newState.stockType = stockType
        }
        
        return newState
    }
}
