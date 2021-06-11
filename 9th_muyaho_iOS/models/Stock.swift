//
//  Stock.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/05/23.
//

struct Stock: Decodable {
    
    let id: Int
    let code: String
    let name: String
    let type: StockType
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case code = "code"
        case name = "name"
        case type = "type"
    }
    
    init() {
        self.id = -1
        self.code = ""
        self.name = ""
        self.type = .domestic
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try values.decodeIfPresent(Int.self, forKey: .id) ?? -1
        self.code = try values.decodeIfPresent(String.self, forKey: .code) ?? ""
        self.name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
        self.type = try values.decodeIfPresent(StockType.self, forKey: .type) ?? .domestic
    }
}
