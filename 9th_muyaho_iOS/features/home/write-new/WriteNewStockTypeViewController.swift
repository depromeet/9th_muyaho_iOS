//
//  WriteNewStockTypeViewController.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/05/20.
//

import RxSwift

class WriteNewStockTypeViewController: BaseViewController {
    
    private let writeNewStockTypeView = WriteNewStockTypeView()
    private let searchStockTransition = SearchStockTransition()
    
    
    static func instance() -> UINavigationController {
        let viewController = WriteNewStockTypeViewController(nibName: nil, bundle: nil)
        
        return UINavigationController(rootViewController: viewController).then {
            $0.modalPresentationStyle = .overCurrentContext
            $0.setNavigationBarHidden(true, animated: false)
        }
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
