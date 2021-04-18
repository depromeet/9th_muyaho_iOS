//
//  HomeViewController.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/04/18.
//

import RxSwift
import ReactorKit

class HomeViewController: BaseViewController, View {
    
    private lazy var homeView = HomeView(frame: self.view.frame)
    private let homeReactor = HomeReactor()
    
    
    static func instance() -> HomeViewController {
        let homeViewController = HomeViewController(nibName: nil, bundle: nil)
        
        homeViewController.tabBarItem = UITabBarItem(title: "홈", image: nil, tag: 0)
        return homeViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = homeView
        self.reactor = homeReactor
    }
    
    func bind(reactor: HomeReactor) {
        // Bind Action
        self.homeView.refreshButton.rx.tap
            .map { HomeReactor.Action.tapRefreshButton(()) }
            .bind(to: self.homeReactor.action)
            .disposed(by: self.disposeBag)
        
        // Bind State
        self.homeReactor.state
            .map { $0.title }
            .distinctUntilChanged()
            .bind(to: self.homeView.titleLabel.rx.text)
            .disposed(by: self.disposeBag)
    }
}
