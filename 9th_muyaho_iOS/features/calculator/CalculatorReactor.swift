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
        case setPlMoney(Double)
        case enableShareButton(Bool)
        case goToShare(Double, Double)
    }
    
    struct State {
        var avgPrice: Double = 0
        var amount: Double = 0
        var purchased: Double = 0
        var goalPrice: Double = 0
        var goalPLRate: Double = 0
        var plMoney: Double = 0
        var isShareButtonEnable = false
    }
    
    let initialState = State()
    let goToSharePublisher = PublishRelay<(Double, Double)>()
    
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .avgPrice(let avgPrice):
            if self.currentState.amount != 0 {
                let purchased = avgPrice * self.currentState.amount
                
                if self.currentState.goalPLRate != 0 {
                    let plMoney = purchased + (purchased * self.currentState.goalPLRate / 100)
                    let goalPrice = avgPrice + (avgPrice * self.currentState.goalPLRate / 100)
                    
                    return .concat([
                        .just(.setAvgPrice(avgPrice)),
                        .just(.setPurchased(purchased)),
                        .just(.setGoalPrice(goalPrice)),
                        .just(.setPlMoney(plMoney)),
                        .just(.enableShareButton(self.isShareEnable()))
                    ])
                } else if self.currentState.goalPrice != 0 {
                    let goalPLRate = self.currentState.goalPrice / avgPrice * 100
                    let plMoney = purchased + (purchased * goalPLRate / 100)
                    
                    return .concat([
                        .just(.setAvgPrice(avgPrice)),
                        .just(.setPurchased(purchased)),
                        .just(.setGoalPLRate(goalPLRate)),
                        .just(.setPlMoney(plMoney)),
                        .just(.enableShareButton(self.isShareEnable()))
                    ])
                } else {
                    return .concat([
                        .just(.setAvgPrice(avgPrice)),
                        .just(.setPurchased(purchased)),
                        .just(.enableShareButton(self.isShareEnable()))
                    ])
                }
                
            } else {
                return .concat([
                    .just(.setAvgPrice(avgPrice)),
                    .just(.enableShareButton(self.isShareEnable()))
                ])
            }
        case .amount(let amount):
            if self.currentState.avgPrice != 0 {
                let purchased = amount * self.currentState.avgPrice
                
                if self.currentState.goalPLRate != 0 {
                    let plMoney = purchased * self.currentState.goalPLRate / 100
                    let goalPrice = self.currentState.avgPrice + (self.currentState.avgPrice * self.currentState.goalPLRate / 100)
                    
                    return .concat([
                        .just(.setAmount(amount)),
                        .just(.setPurchased(purchased)),
                        .just(.setGoalPrice(goalPrice)),
                        .just(.setPlMoney(plMoney)),
                        .just(.enableShareButton(self.isShareEnable()))
                    ])
                } else if self.currentState.goalPrice != 0 {
                    let goalPLRate = self.currentState.goalPrice / self.currentState.avgPrice * 100
                    let plMoney = purchased * goalPLRate / 100
                    
                    return .concat([
                        .just(.setAmount(amount)),
                        .just(.setPurchased(purchased)),
                        .just(.setGoalPLRate(goalPLRate)),
                        .just(.setPlMoney(plMoney)),
                        .just(.enableShareButton(self.isShareEnable()))
                    ])
                }
                else {
                    return .concat([
                        .just(.setAmount(amount)),
                        .just(.setPurchased(purchased)),
                        .just(.enableShareButton(self.isShareEnable()))
                    ])
                }
            } else {
                return .concat([
                    .just(.setAmount(amount)),
                    .just(.enableShareButton(self.isShareEnable()))
                ])
            }
        case .goalPrice(let goalPrice):
            if self.currentState.purchased != 0 {
                let goalPLRate = (goalPrice - self.currentState.avgPrice) / self.currentState.avgPrice * 100
                let plMoney =  self.currentState.purchased * goalPLRate / 100
                
                return .concat([
                    .just(.setGoalPrice(goalPrice)),
                    .just(.setGoalPLRate(goalPLRate)),
                    .just(.setPlMoney(plMoney)),
                    .just(.enableShareButton(self.isShareEnable()))
                ])
            } else {
                return .just(.setGoalPrice(goalPrice))
            }
        case .goalPLRate(let goalPLRate):
            if self.currentState.purchased != 0 {
                let goalPrice = self.currentState.avgPrice + (self.currentState.avgPrice * goalPLRate / 100)
                let plMoney =  self.currentState.purchased * self.currentState.goalPLRate / 100
                
                return .concat([
                    .just(.setGoalPrice(goalPrice)),
                    .just(.setGoalPLRate(goalPLRate)),
                    .just(.setPlMoney(plMoney)),
                    .just(.enableShareButton(self.isShareEnable()))
                ])
            } else {
                return .just(.setGoalPLRate(goalPLRate))
            }
        case .tapShareButton:
            return .just(.goToShare(self.currentState.goalPrice, self.currentState.goalPLRate))
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
        case .setGoalPrice(let goalPrice):
            newState.goalPrice = goalPrice
        case .setGoalPLRate(let goalPLRate):
            newState.goalPLRate = goalPLRate
        case .enableShareButton(let isEnable):
            newState.isShareButtonEnable = isEnable
        case .setPlMoney(let plMoney):
            newState.plMoney = plMoney
        case .goToShare(let plMoney, let plRate):
            self.goToSharePublisher.accept((plMoney, plRate))
        }
        return newState
    }
    
    private func isShareEnable() -> Bool {
        return self.currentState.avgPrice != 0
            && self.currentState.amount != 0
            && self.currentState.goalPrice != 0
            && self.currentState.goalPLRate != 0
    }
}
