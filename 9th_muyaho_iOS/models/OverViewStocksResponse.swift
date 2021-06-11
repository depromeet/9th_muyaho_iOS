//
//  OverViewStocksResponse.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/06/05.
//

import Foundation

struct OverviewStocksResponse: Decodable {
    
    let bitCoins: [StockCalculateResponse]
    let domesticStocks: [StockCalculateResponse]
    let foreignStocks: [StockCalculateResponse]
    
    enum CodingKeys: String, CodingKey {
        
        case bitCoins
        case domesticStocks
        case foreignStocks
    }
    
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.bitCoins = try values.decodeIfPresent([StockCalculateResponse].self, forKey: .bitCoins) ?? []
        self.domesticStocks = try values.decodeIfPresent([StockCalculateResponse].self, forKey: .domesticStocks) ?? []
        self.foreignStocks = try values.decodeIfPresent([StockCalculateResponse].self, forKey: .foreignStocks) ?? []
    }
    
    init() {
        self.bitCoins = []
        self.domesticStocks = []
        self.foreignStocks = []
    }
}
