//
//  InventStatusResponse.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/06/05.
//

import Foundation

struct InvestStatusResponse: Decodable {
    
    let todayProfitOrLose: String
    let finalAsset: String
    let seedAmount: String
    let finalProfitOrLoseRate: String
    let overview: OverviewStocksResponse
    
    enum CodingKeys: String, CodingKey {
        
        case todayProfitOrLose
        case finalAsset
        case seedAmount
        case finalProfitOrLoseRate
        case overview
    }
    
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.todayProfitOrLose = try values.decodeIfPresent(String.self, forKey: .todayProfitOrLose) ?? ""
        self.finalAsset = try values.decodeIfPresent(String.self, forKey: .finalAsset) ?? ""
        self.seedAmount = try values.decodeIfPresent(String.self, forKey: .seedAmount) ?? ""
        self.finalProfitOrLoseRate = try values.decodeIfPresent(String.self, forKey: .finalProfitOrLoseRate) ?? ""
        self.overview = try values.decodeIfPresent(OverviewStocksResponse.self, forKey: .overview) ?? OverviewStocksResponse()
    }
}
