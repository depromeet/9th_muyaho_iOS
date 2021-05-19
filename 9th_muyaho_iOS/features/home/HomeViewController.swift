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
    
    override func bindEvent() {
        self.homeView.writeButton.rx.tap
            .observeOn(MainScheduler.instance)
            .bind(onNext: self.showshowWriteMenus)
            .disposed(by: self.eventDisposeBag)
    }
    
    func bind(reactor: HomeReactor) {
        // Bind Action
        self.homeView.refreshButton.rx.tap
            .map { HomeReactor.Action.tapRefreshButton(()) }
            .bind(to: self.homeReactor.action)
            .disposed(by: self.disposeBag)
    }
    
    private func showshowWriteMenus() {
        let writeMenuViewController = WriteMenuViewController.instance().then {
            $0.delegate = self
        }
        self.present(writeMenuViewController, animated: true, completion: nil)
    }
}


extension HomeViewController: WriteMenuDelegate {
    
    func onTapNew() {
        print("onTapNew")
    }
    
    func onTapModify() {
        print("onTapModify")
    }
}
