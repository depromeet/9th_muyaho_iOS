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
        let tabIconOff = UIImage.icHomeOff
        let tabIconOn = UIImage.icHomeOn
        
        tabIconOn?.withRenderingMode(.alwaysOriginal)
        tabIconOff?.withRenderingMode(.alwaysOriginal)
        let tabBarItem = UITabBarItem(
            title: nil,
            image: tabIconOff,
            selectedImage: tabIconOn
        )
        
        tabBarItem.tag = TabbarTag.home.rawValue
        homeViewController.tabBarItem = tabBarItem
        return homeViewController
    }
    
    override func setupView() {
        self.view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.reactor = homeReactor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.homeReactor.action.onNext(.viewWillAppear)
    }
    
    override func bindEvent() {
        self.homeView.writeButton.rx.tap
            .observeOn(MainScheduler.instance)
            .bind(onNext: self.showshowWriteMenus)
            .disposed(by: self.eventDisposeBag)
        
        self.homeReactor.stockDetailPublisher
            .asDriver(onErrorJustReturn: (.domestic, OverviewStocksResponse()))
            .drive(onNext: self.pushStockDetailViewController)
            .disposed(by: self.eventDisposeBag)
        
        self.homeReactor.writePublisher
            .asDriver(onErrorJustReturn: .domestic)
            .drive(onNext: self.presnetWriteStockTypeViewController)
            .disposed(by: self.eventDisposeBag)
        
        self.homeView.homeOverview.emptyOverViewButton.rx.tap
            .asDriver()
            .map { StockType.domestic }
            .drive(onNext: self.presnetWriteStockTypeViewController)
            .disposed(by: self.eventDisposeBag)
    }
    
    func bind(reactor: HomeReactor) {
        // MARK: Bind Action
        self.homeView.refreshButton.rx.tap
            .map { Reactor.Action.tapRefresh }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        self.homeView.homeInvestByCategoryView.domesticCategoryButton.rx.tap
            .map { Reactor.Action.tapStockDetail(StockType.domestic) }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        self.homeView.homeInvestByCategoryView.abroadCategoryButton.rx.tap
            .map { Reactor.Action.tapStockDetail(StockType.abroad) }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        self.homeView.homeInvestByCategoryView.coinCategoryButton.rx.tap
            .map { Reactor.Action.tapStockDetail(StockType.coin) }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        // MARK: Bind State
        reactor.state
            .map { $0.investStatusResponse }
            .asDriver(onErrorJustReturn: InvestStatusResponse())
            .drive(self.homeView.rx.investStatus)
            .disposed(by: self.disposeBag)
        
        reactor.state
            .map { $0.loading }
            .asDriver(onErrorJustReturn: false)
            .drive(onNext: self.homeView.setRefreshAnimation(isLoading:))
            .disposed(by: self.disposeBag)
    }
    
    private func showshowWriteMenus() {
        let writeMenuViewController = WriteMenuViewController.instance().then {
            $0.delegate = self
        }
        self.tabBarController?.present(writeMenuViewController, animated: true, completion: nil)
    }
    
    private func pushStockDetailViewController(
        type: StockType,
        overviewStocks: OverviewStocksResponse
    ) {
        let stockDetailViewController = StockDetailViewController.instance(
            type: type,
            overviewStocks: overviewStocks
        )
        
        self.navigationController?.pushViewController(stockDetailViewController, animated: true)
    }
    
    private func presnetWriteStockTypeViewController(type: StockType = .domestic) {
        let writeNewStockTypeViewController = WriteNewStockTypeViewController.instance(stockType: type)
        if let rootVC = writeNewStockTypeViewController.topViewController as? WriteNewStockTypeViewController {
            rootVC.delegate = self
        }
        
        self.tabBarController?.present(
            writeNewStockTypeViewController,
            animated: true,
            completion: nil
        )
    }
}


extension HomeViewController: WriteMenuDelegate {
    
    func onTapNew() {
        self.presnetWriteStockTypeViewController()
    }
    
    func onTapModify() {
        print("onTapModify")
    }
}

extension HomeViewController: WriteNewStockProtocol {
    func onFinishWrite() {
        self.homeReactor.action.onNext(.tapRefresh)
    }
}
