//
//  StockServices.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/05/23.
//

import RxSwift
import RxAlamofire
import Foundation
import Alamofire

protocol StockServiceProtocol {
    
    func fetchStocks(stockType: StockType) -> Observable<ResponseContainer<[Stock]>>
    
    func writeStock(request: WriteStockRequest) -> Observable<ResponseContainer<StockInfo>>
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
    
    func writeStock(request: WriteStockRequest) -> Observable<ResponseContainer<StockInfo>> {
        let urlString = HTTPUtils.endPoint + "/api/v1/member/stock"
        let parameters = request.toParams()
        
        return RxAlamofire.requestJSON(
            .post, urlString,
            parameters: parameters,
            encoding: JSONEncoding.default,
            headers: HTTPUtils.authorizationHeader()
        )
        .map { (response, value) in
            if response.isSuccess {
                return (response, value)
            } else {
                throw HTTPError(rawValue: response.statusCode) ?? .unknown
            }
        }
        .expectingObject(ofType: StockInfo.self)
    }
}
