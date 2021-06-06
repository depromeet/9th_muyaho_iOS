//
//  CalculatorVIewController.swift
//  9th_muyaho_iOS
//
//  Created by 이현호 on 2021/05/22.
//

import RxSwift
import ReactorKit

class CalculatorViewController: BaseViewController, View {
    
    private lazy var calculatorView = CalculatorView(frame: self.view.frame)
    private let calculatorReactor = CalculatorReactor()
    
    
    static func instance() -> CalculatorViewController {
        let calculatorViewController = CalculatorViewController(nibName: nil, bundle: nil)
        let tabIconOff = UIImage.icCalculateOff
        let tabIconOn = UIImage.icCalculateOn
        
        tabIconOn?.withRenderingMode(.alwaysOriginal)
        tabIconOff?.withRenderingMode(.alwaysOriginal)
        let tabBarItem = UITabBarItem(
            title: nil,
            image: tabIconOff,
            selectedImage: tabIconOn
        )
        
        tabBarItem.tag = TabbarTag.calculater.rawValue
        calculatorViewController.tabBarItem = tabBarItem
        return calculatorViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .sub_black_b1
        navigationController?.hidesBarsOnSwipe = true
        navigationController?.navigationBar.backgroundColor = .sub_black_b1
        view = calculatorView
        self.reactor = calculatorReactor
    }
    
    func bind(reactor: CalculatorReactor) {
        // Bind Action
//        self.calculatorView.refreshButton.rx.tap
//
//        
//        // Bind State
//        self.calculatorReactor.state
//            .map { $0.title }
//            .distinctUntilChanged()
//            .bind(to: self.calculatorView.titleLabel.rx.text)
//            .disposed(by: self.disposeBag)
    }
}
