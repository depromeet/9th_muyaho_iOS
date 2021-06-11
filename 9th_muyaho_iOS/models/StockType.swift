//
//  StockType.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/05/20.
//

enum StockType: String, Codable {
    
    case domestic = "DOMESTIC_STOCK"
    case abroad = "OVERSEAS_STOCK"
    case coin = "BITCOIN"
    
    var localizedString: String {
        switch self {
        case .domestic:
            return "investment_category_demestic".localized
        case .abroad:
            return "investment_category_abroad".localized
        case .coin:
            return "investment_category_coin".localized
        }
    }
}
