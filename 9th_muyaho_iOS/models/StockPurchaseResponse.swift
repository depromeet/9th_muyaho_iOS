//
//  StockPurchaseResponse.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/06/05.
//

import Foundation

struct StockPurchaseResponse: Decodable {
    
    let unitPrice: Double
    let amount: Double
    let amountInWon: Double
    
    enum CodingKeys: String, CodingKey {
        case unitPrice
        case amount
        case amountInWon
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.unitPrice = (try values.decodeIfPresent(String.self, forKey: .unitPrice) ?? "0").toDouble()
        self.amount = (try values.decodeIfPresent(String.self, forKey: .amount) ?? "0").toDouble()
        self.amountInWon = (try values.decodeIfPresent(String.self, forKey: .amountInWon) ?? "0").toDouble()
    }
    
    init() {
        self.unitPrice = 0
        self.amount = 0
        self.amountInWon = 0
    }
}
