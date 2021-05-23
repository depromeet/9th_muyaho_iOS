//
//  NSObject + reusableIdentifier.swift
//  9th_muyaho_iOS
//
//  Created by 이현호 on 2021/05/22.
//

import Foundation

extension NSObject {
    static var reusableIdentifier: String {
        return String(describing: self)
    }
}
