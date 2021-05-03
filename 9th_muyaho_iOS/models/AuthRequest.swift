//
//  AccessToken.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/04/29.
//

struct AuthRequest: Encodable, Equatable {
    
    let provider: SocialType
    let token: String
    
    func toDict() -> [String: Any] {
        return [
            "provider": self.provider.rawValue,
            "token": self.token
        ]
    }
}
