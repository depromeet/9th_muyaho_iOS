//
//  AuthResponse.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/05/01.
//

struct AuthResponse: Decodable {
    
    let sessionId: String
    
    enum CodingKeys: String, CodingKey {
        case sessionId = "sessionId"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        sessionId = try values.decodeIfPresent(String.self, forKey: .sessionId) ?? ""
    }
}
