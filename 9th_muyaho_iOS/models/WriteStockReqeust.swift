//
//  WriteStockReqeust.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/05/30.
//

struct WriteStockRequest {
    
    let stockId: Int
    let purchasePrice: Double
    let quantity: Double
    let currencyType: CurrencyType
    let purchaseTotalPrice: Double
    
    func toParams() -> [String: Any] {
        return [
            "stockId": stockId,
            "purchasePrice": purchasePrice,
            "quantity": quantity,
            "currencyType": currencyType.rawValue,
            "purchaseTotalPrice": purchaseTotalPrice
        ]
    }
}
