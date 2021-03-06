//
//  SocialType.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/04/29.
//

enum SocialType: String, Encodable {
    
    case kakao = "KAKAO"
    case apple = "APPLE"
    
    var lowercase: String {
        switch self {
        case .kakao:
            return "kakao"
        case .apple:
            return "apple"
        }
    }
}
