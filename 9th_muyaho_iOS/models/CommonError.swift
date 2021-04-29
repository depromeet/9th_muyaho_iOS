//
//  CommonError.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/04/29.
//

import Foundation

struct CommonError: Error {
    
    let description: String
    
    init(description: String) {
        self.description = description
    }
    
    init(error: Error) {
        self.description = error.localizedDescription
    }
}
