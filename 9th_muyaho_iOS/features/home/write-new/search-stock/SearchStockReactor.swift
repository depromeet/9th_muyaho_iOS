//
//  SearchStockReactor.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/05/23.
//

import RxSwift
import RxCocoa
import ReactorKit

class SearchStockReactor: Reactor {
    
    enum Action {
        case inputKeyword(String)
        case selectStock(Int)
    }
    
    enum Mutation {
        case setStocks([Stock])
        case goWriteDetail(Stock)
    }
    
    struct State {
        var searchedStocks: [Stock] = []
    }
    
    let initialState: State = State()
    let disposeBag = DisposeBag()
    let goWriteDetailPublisher = PublishRelay<Stock>()
    var stocks: [Stock] = []
    let stockType: StockType
    let stockService: StockServiceProtocol
    let userDefaults: UserDefaultsUtils
    
    
    init(
        stockType: StockType,
        stockService: StockServiceProtocol,
        userDefaults: UserDefaultsUtils
    ) {
        self.stockType = stockType
        self.stockService = stockService
        self.userDefaults = userDefaults
        self.fetchAllStocks(stockType: self.stockType)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .inputKeyword(let keyword):
            let searchedStocks = self.stocks
                .filter { $0.name.lowercased().contains(keyword.lowercased()) ||
                    $0.code.lowercased().contains(keyword.lowercased())
                }
            
            return .just(.setStocks(searchedStocks))
        case .selectStock(let index):
            let selectedStock = self.currentState.searchedStocks[index]
            
            return .just(.goWriteDetail(selectedStock))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case.setStocks(let stocks):
            newState.searchedStocks = stocks
        case .goWriteDetail(let stock):
            self.goWriteDetailPublisher.accept(stock)
        }
        
        return newState
    }
    
    private func fetchAllStocks(stockType: StockType) {
        self.stockService.fetchStocks(stockType: self.stockType)
            .subscribe(onNext: { [weak self] response in
                self?.stocks = response.data
            })
            .disposed(by: self.disposeBag)
    }
}
