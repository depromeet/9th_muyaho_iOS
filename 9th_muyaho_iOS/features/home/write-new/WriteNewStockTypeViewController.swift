//
//  WriteNewStockTypeViewController.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/05/20.
//

import RxSwift
import ReactorKit

class WriteNewStockTypeViewController: BaseViewController, View {
    
    private let writeNewStockTypeView = WriteNewStockTypeView()
    private let writeNewStockTypeReactor = WriteNewStockTypeReactor()
    private let searchStockTransition = SearchStockTransition()
    
    
    static func instance() -> UINavigationController {
        let viewController = WriteNewStockTypeViewController(nibName: nil, bundle: nil)
        
        return UINavigationController(rootViewController: viewController).then {
            $0.modalPresentationStyle = .overCurrentContext
            $0.setNavigationBarHidden(true, animated: false)
        }
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
        let searchStockViewController = SearchStockViewController.make(stockType: stockType).then {
            $0.delegate = self
        }
        let naviViewController = UINavigationController(rootViewController: searchStockViewController).then {
            $0.isNavigationBarHidden = true
            $0.modalPresentationStyle = .overCurrentContext
            $0.transitioningDelegate = self
        }
        
        self.present(naviViewController, animated: true, completion: nil)
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
        // TODO: 다음 화면 넘기기!
    }
}
