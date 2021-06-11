//
//  ExchangeRateServices.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/06/02.
//

import RxSwift
import RxAlamofire
import Foundation
import Alamofire

protocol ExchangeRateServiceProtocol {
    
    func fetchExchangeRate() -> Observable<Double>
}

struct ExchangeRateService: ExchangeRateServiceProtocol {
    
    func fetchExchangeRate() -> Observable<Double> {
        let urlString = "https://earthquake.kr:23490/query/USDKRW"
        
        return RxAlamofire.requestJSON(.get, urlString)
            .map { (response, value) in
                if response.isSuccess {
                    guard let dictionary = value as? [String: Any] else { return 0 }
                    guard let exchangeRates = dictionary["USDKRW"] as? [Double] else { return 0 }
                    
                    return exchangeRates[0]
                } else {
                    throw HTTPError(rawValue: response.statusCode) ?? .unknown
                }
            }
    }
}
