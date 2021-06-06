//
//  StockDetailChildReactor.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/06/05.
//

import RxSwift
import RxCocoa
import RxDataSources
import ReactorKit

class StockDetailChildReactor: Reactor, BaseReactorProtocol {
    
    enum Action {
        case viewDidLoad
        case refresh
        case tapSettingButton
        case tapFinishButton
        case tapDelete(Int)
    }
    
    enum Mutation {
        case setStocks([StockDetailItemSection])
        case setAlertMessage(String)
        case setEditable(Bool)
    }
    
    struct State {
        var type: StockType
        var alertMessage: String?
        var stocks: [StockDetailItemSection]
        var isEditable = false
    }
    
    let initialState: State
    let stockService: StockServiceProtocol
    
    init(
        type: StockType,
        stocks: [StockCalculateResponse],
         stockService: StockServiceProtocol
    ) {
        var pl: Double = 0
        if type == .abroad {
            pl = stocks
                .map { $0.current.won.amountPrice - $0.purchase.amountInWon }
                .reduce(0, +)
        } else {
            pl = stocks
                .map { $0.current.won.amountPrice - $0.purchase.amount }
                .reduce(0, +)
        }
        let totalMoney = stocks
            .map { $0.current.won.amountPrice }
            .reduce(0, +)
        let firstSection = StockDetailItemSection(
            count: 0,
            type: type,
            totalMoney: totalMoney,
            profiltOrLose: pl,
            items: [StockCalculateResponse()]
        )
        let secondSection = StockDetailItemSection(
            count: 0,
            type: type,
            totalMoney: 0,
            profiltOrLose: 0,
            items: stocks
        )
        self.initialState = State(type: type, stocks: [firstSection, secondSection])
        self.stockService = stockService
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewDidLoad:
            return self.stockService.fetchStatus(by: self.currentState.type)
                .map { [weak self] in
                    guard let self = self else { return .setAlertMessage("error") }
                    let sections = self.transformToSection(
                        type: self.currentState.type,
                        stocks: $0.data
                    )
                    
                    return Mutation.setStocks(sections)
                }
                .catchError(self.handleError(error:))
        case .refresh:
            return self.stockService.fetchStatus(by: self.currentState.type)
                .map { [weak self] in
                    guard let self = self else { return .setAlertMessage("error") }
                    let sections = self.transformToSection(
                        type: self.currentState.type,
                        stocks: $0.data
                    )
                    
                    return Mutation.setStocks(sections)
                }
                .catchError(self.handleError(error:))
        case .tapSettingButton:
            return .just(.setEditable(true))
        case .tapFinishButton:
            return .just(.setEditable(false))
        case .tapDelete(let index):
            let stockId = self.currentState.stocks[1].items[index].memberStockId
            
            return self.stockService.deleteStock(stockId: stockId)
                .flatMap { _ in
                    return self.stockService.fetchStatus(by: self.currentState.type)
                }
                .map { [weak self] in
                    guard let self = self else { return .setAlertMessage("error") }
                    let sections = self.transformToSection(
                        type: self.currentState.type,
                        stocks: $0.data
                    )
                    
                    return Mutation.setStocks(sections)
                }
                .catchError(self.handleError(error:))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .setStocks(let stocks):
            newState.stocks = stocks
        case .setAlertMessage(let message):
            newState.alertMessage = message
        case .setEditable(let isEditable):
            newState.isEditable = isEditable
        }
        return newState
    }
    
    private func handleError(error: Error) -> Observable<Mutation> {
        return self.handleDefaultError(error: error)
            .map { Mutation.setAlertMessage($0) }
    }
    
    private func transformToSection(
        type: StockType,
        stocks: [StockCalculateResponse]
    ) -> [StockDetailItemSection] {
        var pl: Double = 0
        if type == .abroad {
            pl = stocks
                .map { $0.current.won.amountPrice - $0.purchase.amountInWon }
                .reduce(0, +)
        } else {
            pl = stocks
                .map { $0.current.won.amountPrice - $0.purchase.amount }
                .reduce(0, +)
        }
        let totalMoney = stocks
            .map { $0.current.won.amountPrice }
            .reduce(0, +)
        let firstSection = StockDetailItemSection(
            count: 0,
            type: type,
            totalMoney: totalMoney,
            profiltOrLose: pl,
            items: [StockCalculateResponse()]
        )
        let secondSection = StockDetailItemSection(
            count: 0,
            type: type,
            totalMoney: 0,
            profiltOrLose: 0,
            items: stocks
        )
        
        return [firstSection, secondSection]
    }
}
