//
//  WriteNewStockTypeViewController.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/05/20.
//

import RxSwift
import ReactorKit

protocol WriteNewStockProtocol: AnyObject {
    
    func onFinishWrite()
}

class WriteNewStockTypeViewController: BaseViewController, View {
    
    weak var delegate: WriteNewStockProtocol?
    private let writeNewStockTypeView = WriteNewStockTypeView()
    private let writeNewStockTypeReactor: WriteNewStockTypeReactor
    private let searchStockTransition = SearchStockTransition()
    
    static func instance(stockType: StockType) -> UINavigationController {
        let viewController = WriteNewStockTypeViewController(stockType: stockType)
        
        return UINavigationController(rootViewController: viewController).then {
            $0.modalPresentationStyle = .overCurrentContext
            $0.setNavigationBarHidden(true, animated: false)
        }
    }
    
    init(stockType: StockType) {
        self.writeNewStockTypeReactor = WriteNewStockTypeReactor(stockType: stockType)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.reactor = self.writeNewStockTypeReactor
    }
    
    override func setupView() {
        self.view.addSubview(self.writeNewStockTypeView)
        self.writeNewStockTypeView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func bindEvent() {
        self.writeNewStockTypeView.closeButton.rx.tap
            .asDriver()
            .drive(onNext: self.dismiss)
            .disposed(by: self.eventDisposeBag)
    }
    
    func bind(reactor: WriteNewStockTypeReactor) {
        // MARK: Bind action
        self.writeNewStockTypeView.stockTypeRadioGroupView.rx.category
            .map { Reactor.Action.tapStockType($0) }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        self.writeNewStockTypeView.stockSearchButton.rx.tap
            .map { reactor.currentState.stockType }
            .asDriver(onErrorJustReturn: .domestic)
            .drive(onNext: self.showSearchStock)
            .disposed(by: self.eventDisposeBag)
        
        // MARK: Bind state
        reactor.state
            .map { $0.stockType }
            .asDriver(onErrorJustReturn: .domestic)
            .drive(self.writeNewStockTypeView.stockTypeRadioGroupView.rx.select)
            .disposed(by: self.disposeBag)
    }
    
    private func dismiss() {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func showSearchStock(stockType: StockType) {
        let searchStockViewController = SearchStockViewController.instance(stockType: stockType).then {
            $0.delegate = self
        }
        
        searchStockViewController.transitioningDelegate = self
        self.present(searchStockViewController, animated: true, completion: nil)
    }
}

extension WriteNewStockTypeViewController: UIViewControllerTransitioningDelegate {
    func animationController(
        forPresented presented: UIViewController,
        presenting: UIViewController,
        source: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        self.searchStockTransition.transitionType = .present
        self.searchStockTransition.originalFrame = self.writeNewStockTypeView.stockSearchButton.frame
        self.searchStockTransition.originalCenter = self.writeNewStockTypeView.stockSearchButton.center
        return self.searchStockTransition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.searchStockTransition.transitionType = .dismiss
        return self.searchStockTransition
    }
}

extension WriteNewStockTypeViewController: SearchStockDelegate {
    func onSelectStock(stock: Stock) {
        var viewController: BaseViewController
        switch stock.type {
        case .domestic:
            viewController = DomesticDetailViewController.make(stock: stock)
        case .abroad:
            viewController = AbroadDetailViewController.make(stock: stock)
        case .coin:
            viewController = CoinDetailViewController.make(stock: stock)
        }
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
