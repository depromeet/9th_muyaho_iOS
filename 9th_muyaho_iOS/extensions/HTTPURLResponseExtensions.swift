//
//  HTTPURLResponseExtensions.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/05/01.
//

import Foundation


extension HTTPURLResponse {
    
    var isSuccess: Bool {
        return self.statusCode == 200
    }
}
