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
    
    func fetchStatusCache() -> Observable<ResponseContainer<InvestStatusResponse>>
    
    func fetchStatus() -> Observable<ResponseContainer<InvestStatusResponse>>
    
    func fetchStatus(by type: StockType) -> Observable<ResponseContainer<[StockCalculateResponse]>>
    
    func deleteStock(stockId: Int) -> Observable<ResponseContainer<String>>
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
    
    func fetchStatusCache() -> Observable<ResponseContainer<InvestStatusResponse>> {
        let urlString = HTTPUtils.endPoint + "/api/v1/member/stock/status/history"
        let headers = HTTPUtils.authorizationHeader()
        
        return RxAlamofire.requestJSON(
            .get,
            urlString,
            headers: headers
        )
        .map { (response, value) in
            if response.isSuccess {
                return (response, value)
            } else {
                throw HTTPError(rawValue: response.statusCode) ?? .unknown
            }
        }
        .expectingObject(ofType: InvestStatusResponse.self)
    }
    
    func fetchStatus() -> Observable<ResponseContainer<InvestStatusResponse>> {
        let urlString = HTTPUtils.endPoint + "/api/v1/member/stock/status"
        let headers = HTTPUtils.authorizationHeader()
        
        return RxAlamofire.requestJSON(
            .get,
            urlString,
            headers: headers
        )
        .map { (response, value) in
            if response.isSuccess {
                return (response, value)
            } else {
                throw HTTPError(rawValue: response.statusCode) ?? .unknown
            }
        }
        .expectingObject(ofType: InvestStatusResponse.self)
    }
    
    func fetchStatus(by type: StockType) -> Observable<ResponseContainer<[StockCalculateResponse]>> {
        let urlString = HTTPUtils.endPoint + "/api/v1/member/stock"
        let params = ["type": type.rawValue]
        let headers = HTTPUtils.authorizationHeader()
        
        return RxAlamofire.requestJSON(
            .get,
            urlString,
            parameters: params,
            headers: headers
        )
        .map { (response, value) in
            if response.isSuccess {
                return (response, value)
            } else {
                throw HTTPError(rawValue: response.statusCode) ?? .unknown
            }
        }
        .expectingObject(ofType: [StockCalculateResponse].self)
    }
    
    func deleteStock(stockId: Int) -> Observable<ResponseContainer<String>> {
        let urlString = HTTPUtils.endPoint + "/api/v1/member/stock"
        let paramas = ["memberStockId": stockId]
        let headers = HTTPUtils.authorizationHeader()
        
        return RxAlamofire.requestJSON(
            .delete,
            urlString,
            parameters: paramas,
            headers: headers
        )
        .map { (response, value) in
            if response.isSuccess {
                return (response, value)
            } else {
                throw HTTPError(rawValue: response.statusCode) ?? .unknown
            }
        }
        .expectingObject(ofType: String.self)
    }
}
