//
//  CommonError.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/04/29.
//

import Foundation

enum CommonError: Error {
    
    case custom(String)
    
    var message: String {
        switch self {
        case .custom(let message):
            return message
        }
    }
}
