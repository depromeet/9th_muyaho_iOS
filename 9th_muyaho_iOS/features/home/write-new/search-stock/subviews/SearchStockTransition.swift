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
    var fieldContainer = UIView().then {
        $0.backgroundColor = .red
    }
    
    enum TransitionType {
        case present
        case dismiss
    }
    
    private func present(using context: UIViewControllerContextTransitioning) {
        if let searchStockViewController = context.viewController(forKey: .to) as? SearchStockViewController {
            let containerView = context.containerView
            
            containerView.backgroundColor = .sub_black_b1
            containerView.addSubview(searchStockViewController.view)
            containerView.addSubview(fieldContainer)
            searchStockViewController.view.layoutIfNeeded()
            searchStockViewController.view.alpha = 0
            
            
            UIView.animate(withDuration: self.duration) {
                self.fieldContainer.frame = searchStockViewController.searchStockView.searchStockField.frame
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
            
            searchStockViewController.view.removeFromSuperview()
            containerView.addSubview(self.fieldContainer)
            self.fieldContainer.frame = searchStockViewController.searchStockView.searchStockField.frame
            UIView.animate(withDuration: self.duration) {
                containerView.backgroundColor = .sub_black_b1
                self.fieldContainer.frame = self.originalFrame
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
