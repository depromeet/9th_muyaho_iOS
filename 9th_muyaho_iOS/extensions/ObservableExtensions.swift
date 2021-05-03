//
//  ObservableExtensions.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/05/01.
//

import Foundation
import RxSwift

extension Observable where Element == (HTTPURLResponse, Any) {
    
    func expectingObject<T: Decodable>(ofType type: T.Type) -> Observable<ResponseContainer<T>> {
        return self.map { (response, value) in
            if response.isSuccess {
                if let object: ResponseContainer<T> =  JsonUtils.toJson(object: value) {
                    return object
                } else {
                    throw CommonError.custom("JSONDecoder fail to \(T.self)")
                }
            } else {
                if let httpError = HTTPError(rawValue: response.statusCode) {
                    throw httpError
                } else {
                    throw CommonError.custom("HTTP status code: \(response.statusCode)")
                }
            }
        }
    }
}
