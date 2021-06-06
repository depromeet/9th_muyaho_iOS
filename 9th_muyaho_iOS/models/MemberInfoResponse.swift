//
//  MemberInfoResponse.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/06/06.
//

import Foundation

struct MemberInfoResponse: Decodable {
    
    let name: String
    let profileUrl: String
    let provider: SocialType
    
    enum CodingKeys: String, CodingKey {
        case name
        case profileUrl
        case provider
    }
    
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
        self.profileUrl = try values.decodeIfPresent(String.self, forKey: .profileUrl) ?? ""
        self.provider = SocialType(rawValue: (try values.decodeIfPresent(String.self, forKey: .provider)) ?? "") ?? .kakao
    }
    
    init() {
        self.name = ""
        self.profileUrl = ""
        self.provider = .kakao
    }
}
