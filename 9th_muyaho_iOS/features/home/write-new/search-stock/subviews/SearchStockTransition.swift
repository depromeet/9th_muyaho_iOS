//
//  SearchStockTransition.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/05/21.
//

import UIKit

final class SearchStockTransition: NSObject {
    
    let duration = 0.5
    var transitionType: TransitionType = .present
    var originalFrame = CGRect.zero
    var originalCenter: CGPoint = .zero
    var fieldContainer = UIView()
    
    enum TransitionType {
        case present
        case dismiss
    }
    
    
    private func present(using context: UIViewControllerContextTransitioning) {
        if let searchStockViewController = context.viewController(forKey: .to) as? SearchStockViewController {
            let containerView = context.containerView
            let searchStockButton = StockSearchButton().then {
                $0.translatesAutoresizingMaskIntoConstraints = true
                $0.frame = self.originalFrame
            }
            
            self.fieldContainer = searchStockButton
            containerView.backgroundColor = .sub_black_b1
            containerView.addSubview(searchStockViewController.view)
            containerView.addSubview(fieldContainer)
            containerView.layoutIfNeeded()
            searchStockViewController.view.layoutIfNeeded()
            searchStockViewController.view.alpha = 0
            
            UIView.animate(withDuration: self.duration) {
                self.fieldContainer.center = searchStockViewController.searchStockView.searchStockField.center
                containerView.backgroundColor = .sub_black_b2
            } completion: { isComplete in
                self.fieldContainer.removeFromSuperview()
                searchStockViewController.view.alpha = 1.0
                context.completeTransition(isComplete)
            }
        }
    }
    
    private func dismiss(using context: UIViewControllerContextTransitioning) {
        if let searchStockViewController = context.viewController(forKey: .from) as? SearchStockViewController {
            let containerView = context.containerView
            let searchStockField = SearchStockField().then {
                $0.translatesAutoresizingMaskIntoConstraints = true
                $0.frame = searchStockViewController.searchStockView.searchStockField.frame
            }
            
            searchStockViewController.view.removeFromSuperview()
            self.fieldContainer = searchStockField
            containerView.addSubview(self.fieldContainer)
            UIView.animate(withDuration: self.duration) {
                containerView.backgroundColor = .sub_black_b1
                self.fieldContainer.center = self.originalCenter
            } completion: { isComplete in
                self.fieldContainer.removeFromSuperview()
                context.completeTransition(isComplete)
            }
        }
    }
}

extension SearchStockTransition: UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return self.duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        switch self.transitionType {
        case .present:
            self.present(using: transitionContext)
        case .dismiss:
            self.dismiss(using: transitionContext)
        }
    }
}
