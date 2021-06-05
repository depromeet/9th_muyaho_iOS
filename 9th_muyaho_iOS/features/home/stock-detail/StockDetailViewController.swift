//
//  StockDetailViewController.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/06/05.
//

import UIKit
import RxSwift
import RxCocoa
import ReactorKit

class StockDetailViewController: BaseViewController {
    
    private let stockDetailView = StockDetailView()
    private let pageViewController = UIPageViewController(
        transitionStyle: .scroll,
        navigationOrientation: .horizontal,
        options: nil
    )
    private let pageViewControllers: [UIViewController] = [
        StockDetailChildViewController.instance(),
        StockDetailChildViewController.instance(),
        StockDetailChildViewController.instance()
    ]
    
    static func instance() -> StockDetailViewController {
        return StockDetailViewController(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        self.view = stockDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupPageViewController()
    }
    
    override func bindEvent() {
        self.stockDetailView.backButton.rx.tap
            .asDriver()
            .drive(onNext: self.popupVC)
            .disposed(by: self.eventDisposeBag)
        
        self.stockDetailView.domesticButton.rx.tap
            .asDriver()
            .map { 0 }
            .do(onNext: self.stockDetailView.selectTab(index:))
            .drive(onNext: self.movePageView(index:))
            .disposed(by: self.eventDisposeBag)
        
        self.stockDetailView.abroadButton.rx.tap
            .asDriver()
            .map { 1 }
            .do(onNext: self.stockDetailView.selectTab(index:))
            .drive(onNext: self.movePageView(index:))
            .disposed(by: self.eventDisposeBag)
        
        self.stockDetailView.coinButton.rx.tap
            .asDriver()
            .map { 2 }
            .do(onNext: self.stockDetailView.selectTab(index:))
            .drive(onNext: self.movePageView(index:))
            .disposed(by: self.eventDisposeBag)
    }
    
    private func popupVC() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setupPageViewController() {
        self.addChild(self.pageViewController)
        self.pageViewController.delegate = self
        self.pageViewController.dataSource = self
        self.stockDetailView.containerView.addSubview(self.pageViewController.view)
        self.pageViewController.view.snp.makeConstraints { make in
            make.edges.equalTo(self.stockDetailView.containerView)
        }
        
        self.pageViewController.setViewControllers(
          [self.pageViewControllers[0]],
          direction: .forward,
          animated: false,
          completion: nil
        )
    }
    
    private func movePageView(index: Int) {
        guard let currentViewControllerIndex =
                self.pageViewControllers.firstIndex(of: self.pageViewController.viewControllers![0]) else { return }
        
        if index == 0 {
            self.pageViewController.setViewControllers(
                [self.pageViewControllers[0]],
                direction: .reverse,
                animated: true,
                completion: nil
            )
        } else if index == 1 {
            self.pageViewController.setViewControllers(
                [self.pageViewControllers[1]],
                direction: currentViewControllerIndex > 1 ? .reverse : .forward,
                animated: true,
                completion: nil
            )
        } else {
            self.pageViewController.setViewControllers(
                [self.pageViewControllers[2]],
                direction: .forward,
                animated: true,
                completion: nil
            )
        }
    }
}

extension StockDetailViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerBefore viewController: UIViewController
    ) -> UIViewController? {
        guard let viewControllerIndex = self.pageViewControllers.firstIndex(of: viewController) else {
          return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else {
          return nil
        }
        
        guard self.pageViewControllers.count > previousIndex else {
          return nil
        }
        
        return self.pageViewControllers[previousIndex]
    }
    
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerAfter viewController: UIViewController
    ) -> UIViewController? {
        guard let viewControllerIndex = self.pageViewControllers.firstIndex(of: viewController) else {
          return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        
        guard nextIndex < self.pageViewControllers.count else {
          return nil
        }
        
        guard self.pageViewControllers.count > nextIndex else {
          return nil
        }
        
        return self.pageViewControllers[nextIndex]
    }
    
    func pageViewController(
        _ pageViewController: UIPageViewController,
        didFinishAnimating finished: Bool,
        previousViewControllers: [UIViewController],
        transitionCompleted completed: Bool
    ) {
        if completed {
            guard let viewControllerIndex = self.pageViewControllers.firstIndex(of: self.pageViewController.viewControllers![0]) else {
                return
            }
            
            self.stockDetailView.selectTab(index: viewControllerIndex)            
        }
    }
}
