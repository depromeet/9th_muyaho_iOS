//
//  StockDetailItemSection.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/06/05.
//

import RxDataSources

struct StockDetailItemSection {
    
    var count: Int
    var type: StockType
    var totalMoney: Double
    var profiltOrLose: Double
    var items: [Item]
}

extension StockDetailItemSection: SectionModelType {
    
    typealias Item = StockCalculateResponse
    
    init(original: StockDetailItemSection, items: [StockCalculateResponse]) {
        self = original
        self.count = items.count
        self.items = items
    }
}

