//
//  HTTPError.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/05/03.
//

import Foundation

enum HTTPError: Int, Error {
    
    case notFound = 404
    case conflict = 409
    case internalServerError = 500
    case unknown
    
    var description: String {
        switch self {
        case .notFound:
            return "http_error_not_found".localized
        case .conflict:
            return "http_error_conflict".localized
        case .internalServerError:
            return "http_error_internal_server_error".localized
        case .unknown:
            return "http_error_unknown".localized
        }
    }
}
