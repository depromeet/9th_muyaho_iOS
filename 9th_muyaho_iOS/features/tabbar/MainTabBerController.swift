//
//  MainTabBerController.swift
//  9th_muyaho_iOS
//
//  Created by 이현호 on 2021/04/13.
//

import UIKit

class MainTabBerController: UITabBarController {

    let homeViewController = HomeViewController.instance()
    
    static func make() -> MainTabBerController {
        return MainTabBerController(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        self.setupTabBar()
    }
    
    private func setupTabBar() {
        self.setViewControllers([homeViewController], animated: true)
    }
}
