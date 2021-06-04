//
//  StockPurchaseResponse.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/06/05.
//

import Foundation

struct StockPurchaseResponse: Decodable {
    
    let unitPrice: String
    let amount: String
    let amountInWon: String
    
    enum CodingKeys: String, CodingKey {
        case unitPrice
        case amount
        case amountInWon
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.unitPrice = try values.decodeIfPresent(String.self, forKey: .unitPrice) ?? ""
        self.amount = try values.decodeIfPresent(String.self, forKey: .amount) ?? ""
        self.amountInWon = try values.decodeIfPresent(String.self, forKey: .amountInWon) ?? ""
    }
    
    init() {
        self.unitPrice = ""
        self.amount = ""
        self.amountInWon = ""
    }
}
