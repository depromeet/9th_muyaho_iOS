//
//  UIViewExtensions.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/04/18.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        for view in views {
            self.addSubview(view)
        }
    }
    
    func asImage() -> UIImage {
      let renderer = UIGraphicsImageRenderer(bounds: bounds)
      
      return renderer.image { rendererContext in
        layer.render(in: rendererContext.cgContext)
      }
    }
}
