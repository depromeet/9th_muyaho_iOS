//
//  AlertUtils.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/05/05.
//

import UIKit

struct AlertUtils {
    
    static func show(
        viewController: UIViewController,
        title: String?,
        message: String?,
        actions: [UIAlertAction]
    ) {
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        for action in actions {
            controller.addAction(action)
        }
        viewController.present(controller, animated: true)
    }
    
    static func showWithAction(
        controller: UIViewController,
        title: String? = nil,
        message: String? = nil,
        onTapOk: @escaping (() -> Void)
    ) {
        let okAction = UIAlertAction(title: "common_ok".localized, style: .default) { action in
            onTapOk()
        }
        
        AlertUtils.show(
            viewController: controller,
            title: title,
            message: message,
            actions: [okAction]
        )
    }
    
    static func showWithCancel(
        viewController: UIViewController,
        title: String? = nil,
        message: String? = nil,
        onTapOk: @escaping () -> Void
    ) {
        let okAction = UIAlertAction(title: "common_ok".localized, style: .default) { (action) in
            onTapOk()
        }
        let cancelAction = UIAlertAction(title: "common_cancel".localized, style: .cancel)
        
        AlertUtils.show(
            viewController: viewController,
            title: title,
            message: message,
            actions: [okAction, cancelAction]
        )
    }
    
    static func show(
        viewController: UIViewController,
        title: String?,
        message: String?
    ) {
        let okAction = UIAlertAction(title: "common_ok".localized, style: .default)
        
        AlertUtils.show(
            viewController: viewController,
            title: title,
            message: message,
            actions: [okAction]
        )
    }
}


