//
//  CalculatorVIewController.swift
//  9th_muyaho_iOS
//
//  Created by 이현호 on 2021/05/22.
//

import RxSwift
import ReactorKit

class CalculatorViewController: BaseViewController, View {
    
    private let calculatorView = CalculatorView()
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
    
    override func loadView() {
        self.view = self.calculatorView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.reactor = self.calculatorReactor
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.calculatorView.startSlimeAnimation()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.calculatorView.stopSlimeAnimation()
    }
    
    func bind(reactor: CalculatorReactor) {
        // MARK: Bind Action
        self.calculatorView.avgField.textField.rx.controlEvent(.editingDidEnd)
            .withLatestFrom(self.calculatorView.avgField.rx.text.orEmpty)
            .map { Reactor.Action.avgPrice(Double($0) ?? 0) }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        self.calculatorView.amountField.textField.rx.controlEvent(.editingDidEnd)
            .withLatestFrom(self.calculatorView.amountField.rx.text.orEmpty)
            .map { Reactor.Action.amount(Double($0) ?? 0) }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        self.calculatorView.goalPriceField.textField.rx.controlEvent(.editingDidEnd)
            .withLatestFrom(self.calculatorView.goalPriceField.rx.text.orEmpty)
            .map { Reactor.Action.goalPrice(Double($0) ?? 0)}
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        self.calculatorView.goalPLRateField.textField.rx.controlEvent(.editingDidEnd)
            .withLatestFrom(self.calculatorView.goalPLRateField.rx.text.orEmpty)
            .map { Reactor.Action.goalPLRate(Double($0) ?? 0)}
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        self.calculatorView.shareButton.rx.tap
            .map { Reactor.Action.tapShareButton }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        // MARK: Bind State
        reactor.state
            .map { String($0.purchased) }
            .distinctUntilChanged()
            .asDriver(onErrorJustReturn: "calculate_purchased".localized)
            .drive(self.calculatorView.purchasedLabel.rx.text)
            .disposed(by: self.disposeBag)
        
        reactor.state
            .map { $0.goalPrice }
            .distinctUntilChanged()
            .asDriver(onErrorJustReturn: 0)
            .map { $0 == 0 ? nil : String($0) }
            .drive(self.calculatorView.goalPriceField.rx.text)
            .disposed(by: self.disposeBag)
        
        reactor.state
            .map { $0.goalPLRate }
            .distinctUntilChanged()
            .asDriver(onErrorJustReturn: 0)
            .map { $0 == 0 ? nil : String($0) }
            .drive(self.calculatorView.goalPLRateField.rx.text)
            .disposed(by: self.disposeBag)
        
        reactor.state
            .map { ($0.plMoney, $0.goalPLRate) }
            .debug()
            .asDriver(onErrorJustReturn: (0, 0))
            .drive(self.calculatorView.rx.pl)
            .disposed(by: self.disposeBag)
        
        reactor.state
            .map { $0.isShareButtonEnable }
            .distinctUntilChanged()
            .asDriver(onErrorJustReturn: false)
            .drive(self.calculatorView.shareButton.rx.isEnabled)
            .disposed(by: self.disposeBag)
    }
}
