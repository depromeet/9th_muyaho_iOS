//
//  UIStringExtensions.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/04/29.
//

import Foundation

extension String {
    
    var localized: String {
        return NSLocalizedString(self, tableName: "Localization", value: self, comment: "")
    }
    
    func toDouble() -> Double {
        return Double(self) ?? 0
    }
}

