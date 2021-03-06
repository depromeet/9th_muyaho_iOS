//
//  JsonUtils.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/05/01.
//

import Foundation

struct JsonUtils {
  
  static func toJson<T: Decodable>(object: Any) -> T? {
    if let jsonData = try? JSONSerialization.data(withJSONObject: object) {
      let decoder = JSONDecoder()
      let result = try? decoder.decode(T.self, from: jsonData)
      
      return result
    } else {
      return nil
    }
  }
}

