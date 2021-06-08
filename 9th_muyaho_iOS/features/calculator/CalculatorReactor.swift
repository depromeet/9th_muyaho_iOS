//
//  CalculatorReactor.swift
//  9th_muyaho_iOS
//
//  Created by 이현호 on 2021/05/22.
//

import ReactorKit
import RxCocoa

class CalculatorReactor: Reactor {
    
    enum Action {
        case avgPrice(Double)
        case amount(Double)
        case purchased(Double)
        case goalPrice(Double)
        case goalPLRate(Double)
        case tapShareButton
    }
    
    enum Mutation {
        case setAvgPrice(Double)
        case setAmount(Double)
        case setPurchased(Double)
        case setGoalPrice(Double)
        case setGoalPLRate(Double)
        case goToShare(Double, Double)
    }
    
    struct State {
        var avgPrice: Double = 0
        var amount: Double = 0
        var purchased: Double = 0
        var goalPrice: Double = 0
        var goalPLRate: Double = 0
        var isShareButtonEnable = false
    }
    
    let initialState = State()
    let goToSharePublisher = PublishRelay<(Double, Double)>()
    
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .avgPrice(let avgPrice):
            return .just(.setAvgPrice(avgPrice))
        case .amount(let amount):
            return .just(.setAmount(amount))
        case .purchased(let purchased):
            return .just(.setPurchased(purchased))
        case .goalPrice(let goalPrice):
            
            return .concat([
                .just(.setGoalPrice(goalPrice))
            ])
        case .goalPLRate(let goalPLRate):
            return .concat([
                .just(.setGoalPLRate(goalPLRate))
            ])
        case .tapShareButton:
            return .just(.goToShare(self.currentState.goalPrice, self.currentState.goalPLRate))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        
        return newState
    }
}
