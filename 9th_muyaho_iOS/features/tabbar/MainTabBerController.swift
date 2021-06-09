//
//  MainTabBerController.swift
//  9th_muyaho_iOS
//
//  Created by 이현호 on 2021/04/13.
//

import UIKit

class MainTabBerController: UITabBarController {

    let homeViewController = HomeViewController.instance()
    let calculatorViewController = CalculatorViewController.instance()
    let boardViewController = BoardViewController.instacne()
    let myPageViewController = MyPageViewController.instance()
    

  
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
        
        homeNaviViewController.interactivePopGestureRecognizer?.delegate = nil
        homeNaviViewController.setNavigationBarHidden(true, animated: false)
        let calculatorNaviViewController = UINavigationController(rootViewController: calculatorViewController)
        calculatorNaviViewController.setNavigationBarHidden(true, animated: false)
        self.setViewControllers([
            homeNaviViewController,
            calculatorNaviViewController,
            boardViewController,
            myPageViewController
        ], animated: true)
        self.tabBar.tintColor = .sub_white_w2
        self.tabBar.barTintColor = .sub_black_b1
    }
}
