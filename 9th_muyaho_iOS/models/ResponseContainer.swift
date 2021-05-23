//
//  ResponseContainer.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/05/01.
//

struct ResponseContainer<T: Decodable>: Decodable {
    
    let code: String
    let message: String
    let data: T
}
