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
        case avgPrice(Int)
        case amount(Int)
        case goalPLRate(Int)
        case tapShareButton
    }
    
    enum Mutation {
        case setAvgPrice(Int)
        case setAmount(Int)
        case setPurchased(Int)
        case setGoalPLRate(Int)
        case setPlMoney(Int)
        case enableShareButton
        case goToShare(Int, Int)
    }
    
    struct State {
        var avgPrice: Int = 0
        var amount: Int = 0
        var purchased: Int = 0
        var goalPLRate: Int = 0
        var plMoney: Int = 0
        var isShareButtonEnable = false
    }
    
    let initialState = State()
    let goToSharePublisher = PublishRelay<(Int, Int)>()
    
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .avgPrice(let avgPrice):
            if self.currentState.amount != 0 {
                let purchased = avgPrice * self.currentState.amount
                
                if self.currentState.goalPLRate != 0 {
                    let plMoney = purchased * (self.currentState.goalPLRate / 100)
                    
                    return .concat([
                        .just(.setAvgPrice(avgPrice)),
                        .just(.setPurchased(purchased)),
                        .just(.setPlMoney(plMoney)),
                        .just(.enableShareButton)
                    ])
                } else {
                    return .concat([
                        .just(.setAvgPrice(avgPrice)),
                        .just(.setPurchased(purchased)),
                        .just(.enableShareButton)
                    ])
                }
                
            } else {
                return .concat([
                    .just(.setAvgPrice(avgPrice)),
                    .just(.enableShareButton)
                ])
            }
        case .amount(let amount):
            if self.currentState.avgPrice != 0 {
                let purchased = amount * self.currentState.avgPrice
                
                if self.currentState.goalPLRate != 0 {
                    let plMoney = purchased * (self.currentState.goalPLRate / 100)
                    
                    return .concat([
                        .just(.setAmount(amount)),
                        .just(.setPurchased(purchased)),
                        .just(.setPlMoney(plMoney)),
                        .just(.enableShareButton)
                    ])
                } else {
                    return .concat([
                        .just(.setAmount(amount)),
                        .just(.setPurchased(purchased)),
                        .just(.enableShareButton)
                    ])
                }
            } else {
                return .concat([
                    .just(.setAmount(amount)),
                    .just(.enableShareButton)
                ])
            }
        case .goalPLRate(let goalPLRate):
            if self.currentState.purchased != 0 {
                let plMoney =  self.currentState.purchased * goalPLRate / 100
                
                return .concat([
                    .just(.setGoalPLRate(goalPLRate)),
                    .just(.setPlMoney(plMoney)),
                    .just(.enableShareButton)
                ])
            } else {
                return .just(.setGoalPLRate(goalPLRate))
            }
        case .tapShareButton:
            return .just(.goToShare(self.currentState.purchased, self.currentState.goalPLRate))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .setAvgPrice(let avgPrice):
            newState.avgPrice = avgPrice
        case .setAmount(let amount):
            newState.amount = amount
        case .setPurchased(let purchased):
            newState.purchased = purchased
        case .setGoalPLRate(let goalPLRate):
            newState.goalPLRate = goalPLRate
        case .enableShareButton:
            newState.isShareButtonEnable = newState.goalPLRate != 0
                && newState.purchased != 0
        case .setPlMoney(let plMoney):
            newState.plMoney = plMoney
        case .goToShare(let plMoney, let plRate):
            self.goToSharePublisher.accept((plMoney, plRate))
        }
        return newState
    }
}
