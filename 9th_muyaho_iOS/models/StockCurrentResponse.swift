//
//  StockCurrentResponse.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/06/05.
//

import Foundation

struct StockCurrentResponse: Decodable {
    
    let won: StockCurrentPriceResponse
    let dollar: StockCurrentPriceResponse
    
    enum CodingKeys: String, CodingKey {
        
        case won
        case dollar
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.won = try values.decodeIfPresent(StockCurrentPriceResponse.self, forKey: .won) ?? StockCurrentPriceResponse()
        self.dollar = try values.decodeIfPresent(StockCurrentPriceResponse.self, forKey: .dollar) ?? StockCurrentPriceResponse()
    }
    
    init() {
        self.won = StockCurrentPriceResponse()
        self.dollar = StockCurrentPriceResponse()
    }
}
