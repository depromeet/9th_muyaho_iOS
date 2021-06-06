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
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        self.tabBar.barTintColor = item.tag == TabbarTag.mypage.rawValue ? .primary_dark : .sub_black_b1
        self.tabBar.isTranslucent = false
    }
    
    private func setupTabBar() {
        let homeNaviViewController = UINavigationController(rootViewController: homeViewController)
        
        homeNaviViewController.setNavigationBarHidden(true, animated: false)
        self.setViewControllers([
            homeNaviViewController,
            calculatorViewController,
            myPageViewController
        ], animated: true)
        self.tabBar.tintColor = .sub_white_w2
        self.tabBar.barTintColor = .sub_black_b1
    }
}
