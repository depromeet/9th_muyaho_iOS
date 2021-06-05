//
//  HomeViewController.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/04/18.
//

import RxSwift
import ReactorKit

class HomeViewController: BaseViewController, View {
    
    private let homeView = HomeView()
    private let homeReactor = HomeReactor(stockService: StockService())
    
    
    static func instance() -> HomeViewController {
        let homeViewController = HomeViewController(nibName: nil, bundle: nil)
        
        homeViewController.tabBarItem = UITabBarItem(title: "홈", image: nil, tag: 0)
        return homeViewController
    }
    
    override func setupView() {
        self.view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.reactor = homeReactor
        self.homeReactor.action.onNext(.viewDidLoad)
    }
    
    override func bindEvent() {
        self.homeView.writeButton.rx.tap
            .observeOn(MainScheduler.instance)
            .bind(onNext: self.showshowWriteMenus)
            .disposed(by: self.eventDisposeBag)
    }
    
    func bind(reactor: HomeReactor) {
        // MARK: Bind Action
        self.homeView.refreshButton.rx.tap
            .map { Reactor.Action.tapRefresh }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        // MARK: Bind State
        reactor.state
            .map { $0.investStatusResponse }
            .asDriver(onErrorJustReturn: InvestStatusResponse())
            .drive(self.homeView.rx.investStatus)
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
        let writeNewStockTypeViewController = WriteNewStockTypeViewController.instance()
        
        self.present(writeNewStockTypeViewController, animated: true, completion: nil)
    }
    
    func onTapModify() {
        print("onTapModify")
    }
}
