//
//  StockInfo.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/05/30.
//

struct StockInfo: Decodable {
    
    let memberStockId: Int
    let stock: Stock
    let currencyType: CurrencyType
    let quantity: String
    let purchasePrice: String
    let purchaseAmount: String
    let purchaseAmountInWon: String
    
    enum CodingKeys: String, CodingKey {
        case memberStockId = "memberStockId"
        case stock = "stock"
        case currencyType = "currencyType"
        case quantity = "quantity"
        case purchasePrice = "purchasePrice"
        case purchaseAmount = "purchaseAmount"
        case purchaseAmountInWon = "purchaseAmountInWon"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.memberStockId = try values.decodeIfPresent(Int.self, forKey: .memberStockId) ?? -1
        self.stock = try values.decodeIfPresent(Stock.self, forKey: .stock) ?? Stock()
        self.currencyType = try values.decodeIfPresent(CurrencyType.self, forKey: .currencyType) ?? .won
        self.quantity = try values.decodeIfPresent(String.self, forKey: .quantity) ?? ""
        self.purchasePrice = try values.decodeIfPresent(String.self, forKey: .purchasePrice) ?? ""
        self.purchaseAmount = try values.decodeIfPresent(String.self, forKey: .purchaseAmount) ?? ""
        self.purchaseAmountInWon = try values.decodeIfPresent(String.self, forKey: .purchaseAmountInWon) ?? ""
    }
}
