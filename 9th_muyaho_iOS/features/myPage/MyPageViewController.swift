//
//  MyPageViewController.swift
//  9th_muyaho_iOS
//
//  Created by 이현호 on 2021/05/09.
//

import RxSwift
import ReactorKit

class MyPageViewController: BaseViewController, View {
    
    private lazy var myPageView = MyPageView(frame: self.view.frame)
    private let myPageReactor = MyPageReactor()

    
    static func instance() -> MyPageViewController {
        let myPageViewController = MyPageViewController(nibName: nil, bundle: nil)
        let tabIconOff = UIImage.icMyPageOff
        let tabIconOn = UIImage.icMyPageOn
        
        tabIconOn?.withRenderingMode(.alwaysOriginal)
        tabIconOff?.withRenderingMode(.alwaysOriginal)
        let tabBarItem = UITabBarItem(
            title: nil,
            image: tabIconOff,
            selectedImage: tabIconOn
        )
        tabBarItem.tag = TabbarTag.mypage.rawValue
        myPageViewController.tabBarItem = tabBarItem
        return myPageViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = myPageView
        self.reactor = myPageReactor
    }
    
    func bind(reactor: MyPageReactor) {
        
    }
}
