//
//  WriteDetailReactor.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/05/29.
//

import RxSwift
import RxCocoa
import ReactorKit

class DomesticDetailReactor: Reactor {
    
    enum Action {
        case avgPrice(Double)
        case amount(Int)
        case tapSaveButton
    }
    
    enum Mutation {
        case setAvgPrice(Double)
        case setAmount(Int)
        case saveStock
        case setTotalPrice(Double)
        case setSaveButtonEnable(Bool)
        case showAlert(String)
    }
    
    struct State {
        var stockType: StockType
        var stockName: String
        var isSaveButtonEnable = false
        var avgPrice = 0.0
        var amount = 0
        var totalPrice = 0.0
    }
    
    let stock: Stock
    let initialState: State
    let stockService: StockServiceProtocol
    let dismissPublisher = PublishRelay<Void>()
    let alertPublisher = PublishRelay<String>()
    
    
    init(stock: Stock, stockService: StockServiceProtocol) {
        self.stock = stock
        self.stockService = stockService
        self.initialState = State(stockType: stock.type, stockName: stock.name)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .avgPrice(let price):
            let totalPrice = price * Double(self.currentState.amount)
            
            return .concat([
                .just(.setAvgPrice(price)),
                .just(.setTotalPrice(totalPrice)),
                .just(.setSaveButtonEnable(totalPrice != 0))
            ])
        case .amount(let amount):
            let totalPrice = self.currentState.avgPrice * Double(amount)
            
            return .concat([
                .just(.setAmount(amount)),
                .just(.setTotalPrice(totalPrice)),
                .just(.setSaveButtonEnable(totalPrice != 0))
            ])
        case .tapSaveButton:
            let writeStockRequest = WriteStockRequest(
                stockId: self.stock.id,
                purchasePrice: self.currentState.avgPrice,
                quantity: self.currentState.amount,
                currencyType: .won,
                purchaseTotalPrice: self.currentState.totalPrice
            )
            
            return self.stockService.writeStock(request: writeStockRequest)
                .map { _ in Mutation.saveStock }
                .catchError(self.handleHTTPError(error:))
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
        case .showAlert(let message):
            self.alertPublisher.accept(message)
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
}
