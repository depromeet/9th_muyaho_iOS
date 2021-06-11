//
//  HTTPUtilities.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/05/01.
//

import Foundation
import Alamofire

struct HTTPUtils {
    
    static let endPoint = Bundle.main.object(forInfoDictionaryKey: "API_URL") as? String ?? ""
    
    static func jsonHeader() -> HTTPHeaders {
        let headers = ["Accept": "application/json"] as HTTPHeaders
        
        return headers
    }
    
    static func authorizationHeader() -> HTTPHeaders {
        let headers = ["Authorization": UserDefaultsUtils().sessionId] as HTTPHeaders
        
        return headers
    }
}
