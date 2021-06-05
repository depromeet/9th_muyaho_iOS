//
//  InventStatusResponse.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/06/05.
//

import Foundation

struct InvestStatusResponse: Decodable {
    
    let todayProfitOrLose: Double
    let finalAsset: Double
    let seedAmount: Double
    let finalProfitOrLoseRate: Double
    let overview: OverviewStocksResponse
    
    var todayStatus: InvestmentStatus {
        if self.seedAmount == 0 {
            return .empty
        } else {
            return todayProfitOrLose > 0 ? .profit : .lose
        }
    }
    
    enum CodingKeys: String, CodingKey {
        
        case todayProfitOrLose
        case finalAsset
        case seedAmount
        case finalProfitOrLoseRate
        case overview
    }
    
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.todayProfitOrLose = (try values.decodeIfPresent(
            String.self,
            forKey: .todayProfitOrLose
        ) ??  "0").toDouble()
        self.finalAsset = (try values.decodeIfPresent(
            String.self,
            forKey: .finalAsset
        ) ?? "0").toDouble()
        self.seedAmount = (try values.decodeIfPresent(String.self, forKey: .seedAmount) ?? "0").toDouble()
        self.finalProfitOrLoseRate = (try values.decodeIfPresent(
            String.self,
            forKey: .finalProfitOrLoseRate
        ) ?? "").toDouble()
        self.overview = try values.decodeIfPresent(
            OverviewStocksResponse.self,
            forKey: .overview
        ) ?? OverviewStocksResponse()
    }
}
