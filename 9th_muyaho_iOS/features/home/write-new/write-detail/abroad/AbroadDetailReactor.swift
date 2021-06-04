//
//  AbroadDetailReactor.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/06/01.
//

import RxSwift
import RxCocoa
import ReactorKit

class AbroadDetailReactor: Reactor {
    
    enum Action {
        case viewDidLoad
        case tapBack
        case tapClose
        case avgPrice(Double)
        case amount(Int)
        case purchasedMoney(Double)
        case tapSaveButton
    }
    
    enum Mutation {
        case setAvgPrice(Double)
        case setAmount(Int)
        case saveStock
        case setTotalPrice(Double)
        case setPurchasedMoney(Double)
        case setTransitionReate(Double)
        case setSaveButtonEnable(Bool)
        case showAlert(String)
        case back(isAlertShow: Bool)
        case close(isAlertShow: Bool)
    }
    
    struct State {
        var stockType: StockType
        var stockName: String
        var isSaveButtonEnable = false
        var avgPrice = 0.0
        var amount = 0
        var transitionRate = 0.0
        var totalPrice = 0.0
        var purchasedMoeny = 0.0
    }
    
    let stock: Stock
    let initialState: State
    let stockService: StockServiceProtocol
    let exchangeRateService: ExchangeRateServiceProtocol
    let dismissPublisher = PublishRelay<Void>()
    let alertPublisher = PublishRelay<String>()
    let backPublisher = PublishRelay<Bool>()
    let closePublisher = PublishRelay<Bool>()
    
    
    init(
        stock: Stock,
        stockService: StockServiceProtocol,
        exchangeRateService: ExchangeRateServiceProtocol
    ) {
        self.stock = stock
        self.stockService = stockService
        self.exchangeRateService = exchangeRateService
        self.initialState = State(stockType: stock.type, stockName: stock.name)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewDidLoad:
            return self.exchangeRateService.fetchExchangeRate()
                .map { Mutation.setTransitionReate($0) }
                .catchError(self.handleHTTPError(error:))
        case .avgPrice(let price):
            if self.currentState.purchasedMoeny == 0 {
                let totalPrice = price * Double(self.currentState.amount) * self.currentState.transitionRate
                
                return .concat([
                    .just(.setAvgPrice(price)),
                    .just(.setTotalPrice(totalPrice)),
                    .just(.setSaveButtonEnable(totalPrice != 0))
                ])
            } else {
                let exchangeRate = self.currentState.purchasedMoeny / (price * Double(self.currentState.amount))
                
                return .concat([
                    .just(.setAvgPrice(price)),
                    .just(.setTransitionReate(exchangeRate)),
                    .just(.setSaveButtonEnable(true))
                ])
            }
            
        case .amount(let amount):
            if self.currentState.purchasedMoeny == 0 {
                let totalPrice = self.currentState.avgPrice * Double(amount)
                
                return .concat([
                    .just(.setAmount(amount)),
                    .just(.setTotalPrice(totalPrice)),
                    .just(.setSaveButtonEnable(totalPrice != 0))
                ])
            } else {
                let exchangeRate = self.currentState.purchasedMoeny / (self.currentState.avgPrice * Double(amount))
                
                return .concat([
                    .just(.setAmount(amount)),
                    .just(.setTransitionReate(exchangeRate)),
                    .just(.setSaveButtonEnable(true))
                ])
            }
            
        case .purchasedMoney(let money):
            let normalPrice = self.currentState.avgPrice * Double(self.currentState.amount)
            
            if normalPrice == 0 {
                return .concat([
                    .just(.setTotalPrice(money)),
                    .just(.setPurchasedMoney(money))
                ])
            } else {
                let transitionRate = money / (self.currentState.avgPrice * Double(self.currentState.amount))
                return .concat([
                    .just(.setTotalPrice(money)),
                    .just(.setPurchasedMoney(money)),
                    .just(.setTransitionReate(transitionRate))
                ])
            }
        case .tapSaveButton:
            let writeStockRequest = WriteStockRequest(
                stockId: self.stock.id,
                purchasePrice: self.currentState.avgPrice,
                quantity: Double(self.currentState.amount),
                currencyType: .dollar,
                purchaseTotalPrice: self.currentState.totalPrice
            )
            
            return self.stockService.writeStock(request: writeStockRequest)
                .map { _ in Mutation.saveStock }
                .catchError(self.handleHTTPError(error:))
        case .tapBack:
            if self.isChangedState() {
                return .just(.back(isAlertShow: true))
            } else {
                return .just(.back(isAlertShow: false))
            }
        case .tapClose:
            if self.isChangedState() {
                return .just(.close(isAlertShow: true))
            } else {
                return .just(.close(isAlertShow: false))
            }
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
        case .setPurchasedMoney(let purchasedMoney):
            newState.purchasedMoeny = purchasedMoney
        case .setTransitionReate(let transitionRate):
            newState.transitionRate = transitionRate
        case .setSaveButtonEnable(let isEnable):
            newState.isSaveButtonEnable = isEnable
        case .showAlert(let message):
            self.alertPublisher.accept(message)
        case .back(let isAlertShow):
            self.backPublisher.accept(isAlertShow)
        case .close(let isAlertShow):
            self.closePublisher.accept(isAlertShow)
        }
        
        return newState
    }
    
    private func handleHTTPError(error: Error) -> Observable<Mutation> {
        if let error = error as? HTTPError {
            return .just(.showAlert(error.description))
        } else {
            return .just(.showAlert(error.localizedDescription))
        }
    }
    
    private func isChangedState() -> Bool {
        return self.initialState.avgPrice != self.currentState.avgPrice
            || self.initialState.amount != self.currentState.amount
    }
}
