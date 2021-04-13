//
//  MainTabBerController.swift
//  9th_muyaho_iOS
//
//  Created by 이현호 on 2021/04/13.
//

import UIKit

class MainTabBerController: UITabBarController {

    
    static func make() -> MainTabBerController {
        return MainTabBerController(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
}
