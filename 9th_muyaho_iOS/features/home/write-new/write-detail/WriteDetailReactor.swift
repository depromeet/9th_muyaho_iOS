//
//  WriteDetailReactor.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/05/29.
//

import RxSwift
import RxCocoa
import ReactorKit

class WriteDetailReactor: Reactor {
    
    enum Action {
        case avgPrice(Double)
        case amount(Int)
        case tapSaveButton
    }
    
    enum Mutation {
        case setAvgPrice(Double)
        case setAmount(Int)
        case saveStock
        case setTotalPrice(Int)
        case setSaveButtonEnable(Bool)
    }
    
    struct State {
        var isSaveButtonEnable = false
        var avgPrice = 0.0
        var amount = 0
        var totalPrice = 0
    }
    
    let stock: Stock
    let initialState = State()
    let dismissPublisher = PublishRelay<Void>()
    
    init(stock: Stock) {
        self.stock = stock
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .avgPrice(let price):
            let totalPrice = Int(price) * self.currentState.amount
            
            return .concat([
                .just(.setAvgPrice(price)),
                .just(.setTotalPrice(totalPrice)),
                .just(.setSaveButtonEnable(totalPrice != 0))
            ])
        case .amount(let amount):
            let totalPrice = Int(self.currentState.avgPrice) * amount
            
            return .concat([
                .just(.setAmount(amount)),
                .just(.setTotalPrice(totalPrice)),
                .just(.setSaveButtonEnable(totalPrice != 0))
            ])
        case .tapSaveButton:
            return .empty()
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .setAvgPrice(let avgPrice):
            newState.avgPrice = avgPrice
        case .setAmount(let amount):
            newState.amount = amount
        case .saveStock:
            self.dismissPublisher.accept(())
        case .setTotalPrice(let totalPrice):
            newState.totalPrice = totalPrice
        case .setSaveButtonEnable(let isEnable):
            newState.isSaveButtonEnable = isEnable
        }
        
        return newState
    }
}
