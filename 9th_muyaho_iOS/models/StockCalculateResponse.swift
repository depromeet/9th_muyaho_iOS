//
//  StockCalulateResponse.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/06/05.
//

import Foundation

struct StockCalculateResponse: Decodable {
    
    let memberStockId: Int
    let stock: Stock
    let purchase: StockPurchaseResponse
    let current: StockCurrentResponse
    let quantity: String
    let currencyType: CurrencyType
    let profitOrLoseRate: String
    
    enum CodingKeys: String, CodingKey {
        case memberStockId
        case stock
        case purchase
        case current
        case quantity
        case currencyType
        case profitOrLoseRate
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.memberStockId = try values.decodeIfPresent(Int.self, forKey: .memberStockId) ?? -1
        self.stock = try values.decodeIfPresent(Stock.self, forKey: .stock) ?? Stock()
        self.purchase = try values.decodeIfPresent(StockPurchaseResponse.self, forKey: .purchase) ?? StockPurchaseResponse()
        self.current = try values.decodeIfPresent(StockCurrentResponse.self, forKey: .current) ?? StockCurrentResponse()
        self.quantity = try values.decodeIfPresent(String.self, forKey: .quantity) ?? ""
        self.currencyType = try values.decodeIfPresent(CurrencyType.self, forKey: .currencyType) ?? .won
        self.profitOrLoseRate = try values.decodeIfPresent(String.self, forKey: .profitOrLoseRate) ?? ""
    }
}
