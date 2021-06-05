//
//  HomeReactor.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/04/18.
//

import ReactorKit

class HomeReactor: Reactor, BaseReactorProtocol {
    
    enum Action {
        case viewDidLoad
        case tapRefresh
    }
    
    enum Mutation {
        case setInvestStatus(InvestStatusResponse)
        case setAlertMessage(String)
    }
    
    struct State {
        var investStatusResponse = InvestStatusResponse()
        var alertMessage: String?
    }
    
    let initialState = State()
    let stockService: StockService
    
    
    init(stockService: StockService) {
        self.stockService = stockService
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewDidLoad:
            let fetchCacheStatus = self.stockService.fetchStatusCache()
                .map { Mutation.setInvestStatus($0.data) }
                .catchError(self.handleError(error:))
            let fetchStatus = self.stockService.fetchStatus()
                .map { Mutation.setInvestStatus($0.data)}
                .catchError(self.handleError(error:))
                
            return .concat([fetchCacheStatus, fetchStatus])
        case .tapRefresh:
            return self.stockService.fetchStatusCache()
                .map { Mutation.setInvestStatus($0.data) }
                .catchError(self.handleError(error:))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .setInvestStatus(let investStatusResponse):
            newState.investStatusResponse = investStatusResponse
        case .setAlertMessage(let message):
            newState.alertMessage = message
        }
        
        return newState
    }
    
    private func handleError(error: Error) -> Observable<Mutation> {
        return self.handleDefaultError(error: error)
            .map { Mutation.setAlertMessage($0) }
    }
}
