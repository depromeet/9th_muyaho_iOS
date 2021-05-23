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
        
        calculatorViewController.tabBarItem = UITabBarItem(title: "계산기", image: nil, tag: 0)
        return calculatorViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        title = "Navigation Bar Title"
        navigationController?.hidesBarsOnSwipe = true
        navigationController?.navigationBar.backgroundColor = .sub_black_b1
        self.view = calculatorView
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
