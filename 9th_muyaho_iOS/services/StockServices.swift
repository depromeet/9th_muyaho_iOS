//
//  StockServices.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/05/23.
//

import RxSwift
import RxAlamofire

protocol StockServiceProtocol {
    
    func fetchStocks(stockType: StockType) -> Observable<ResponseContainer<[Stock]>>
}

struct StockService: StockServiceProtocol {
    
    func fetchStocks(stockType: StockType) -> Observable<ResponseContainer<[Stock]>> {
        let urlString = HTTPUtils.endPoint + "/api/v1/stock/list"
        let parameters = ["type": stockType.rawValue]
        
        return RxAlamofire.requestJSON(.get, urlString, parameters: parameters)
            .map { (response, value) in
                if response.isSuccess {
                    return (response, value)
                } else {
                    throw HTTPError(rawValue: response.statusCode) ?? .unknown
                }
            }
            .expectingObject(ofType: [Stock].self)
    }
}
