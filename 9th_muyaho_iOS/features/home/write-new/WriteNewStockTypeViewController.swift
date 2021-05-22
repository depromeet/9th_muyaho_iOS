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
        
        self.writeNewStockTypeView.stockSearchButton.rx.tap
            .asDriver()
            .drive(onNext: self.showSearchStock)
            .disposed(by: self.eventDisposeBag)
    }
    
    func bind(reactor: WriteNewStockTypeReactor) {
        // MARK: Bind action
        self.writeNewStockTypeView.stockTypeRadioGroupView.rx.category
            .map { Reactor.Action.tapStockType($0) }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
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
    
    private func showSearchStock() {
        let searchStockViewController = SearchStockViewController.instance()
        
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
