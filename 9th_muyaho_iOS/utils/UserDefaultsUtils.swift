//
//  UserDefaultUtils.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/05/04.
//

import Foundation

struct UserDefaultsUtils {
    
    static let KEY_SESSION_ID = "KEY_SESSION_ID"
    
    let instance: UserDefaults
    
    init(name: String? = nil) {
        if let name = name {
            self.instance = UserDefaults(suiteName: name) ?? UserDefaults.standard
        } else {
            self.instance = UserDefaults.standard
        }
    }
    
    var sessionId: String {
        set {
            self.instance.set(newValue, forKey: UserDefaultsUtils.KEY_SESSION_ID)
        }
        
        get {
            self.instance.string(forKey: UserDefaultsUtils.KEY_SESSION_ID) ?? ""
        }
    }
}
