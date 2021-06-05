//
//  MainTabBerController.swift
//  9th_muyaho_iOS
//
//  Created by 이현호 on 2021/04/13.
//

import UIKit

class MainTabBerController: UITabBarController {

    let homeViewController = HomeViewController.instance()
    let myPageViewController = MyPageViewController.instance()
    let calculatorViewController = CalculatorViewController.instance()

  
    static func make() -> MainTabBerController {
        return MainTabBerController(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        self.setupTabBar()
    }
    
    private func setupTabBar() {
        let homeNaviViewController = UINavigationController(rootViewController: homeViewController)
        
        homeNaviViewController.setNavigationBarHidden(true, animated: false)
        self.setViewControllers([
            homeNaviViewController,
            calculatorViewController,
            myPageViewController
        ], animated: true)
        UITabBar.appearance().barTintColor = .sub_black_b1
        self.tabBar.tintColor = .white
    }
}
