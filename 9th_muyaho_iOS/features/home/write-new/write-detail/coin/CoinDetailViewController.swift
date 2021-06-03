//
//  CoinDetailViewController.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/06/04.
//

import UIKit
import ReactorKit

class CoinDetailViewController: BaseViewController, View {
    
    private let coinDetailView = CoinDetailView()
    private let coinDetailReactor: CoinDetailReactor
    
    
    init(stock: Stock) {
        self.coinDetailReactor = CoinDetailReactor(
            stock: stock,
            stockService: StockService()
        )
        super.init(nibName: nil, bundle: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func make(stock: Stock) -> CoinDetailViewController {
        return CoinDetailViewController(stock: stock)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.reactor = self.coinDetailReactor
        self.setupKeyboardNotification()
    }
    
    override func setupView() {
        self.view.addSubview(coinDetailView)
        self.coinDetailView.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
    }
    
    override func bindEvent() {
        self.coinDetailView.tapBackground.rx.event
            .map { _ in Void() }
            .asDriver(onErrorJustReturn: Void())
            .drive(onNext: self.coinDetailView.hideKeyboard)
            .disposed(by: self.eventDisposeBag)
        
        self.coinDetailReactor.dismissPublisher
            .asDriver(onErrorJustReturn: ())
            .drive(onNext: self.dismiss)
            .disposed(by: self.eventDisposeBag)
        
        self.coinDetailReactor.alertPublisher
            .asDriver(onErrorJustReturn: "")
            .drive(onNext: self.showAlert(message:))
            .disposed(by: self.eventDisposeBag)
        
        self.coinDetailReactor.backPublisher
            .asDriver(onErrorJustReturn: true)
            .drive(onNext: self.pop(isAlertShow:))
            .disposed(by: self.eventDisposeBag)
        
        self.coinDetailReactor.closePublisher
            .asDriver(onErrorJustReturn: true)
            .drive(onNext: self.close(isAlertShow:))
            .disposed(by: self.eventDisposeBag)
    }
    
    func bind(reactor: CoinDetailReactor) {
        // MARK: Bind Action
        self.coinDetailView.backButton.rx.tap
            .map { Reactor.Action.tapBack }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        self.coinDetailView.closeButton.rx.tap
            .map { Reactor.Action.tapClose }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        self.coinDetailView.avgPriceField.rx.text
            .map { Reactor.Action.avgPrice(Double($0.replacingOccurrences(of: ",", with: "")) ?? 0) }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        self.coinDetailView.saveButton.rx.tap
            .map { Reactor.Action.tapSaveButton }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        // MARK: Bind State
        reactor.state
            .map { $0.stockType }
            .asDriver(onErrorJustReturn: .domestic)
            .drive(self.coinDetailView.rx.stockType)
            .disposed(by: self.disposeBag)
        
        reactor.state
            .map { $0.stockName }
            .asDriver(onErrorJustReturn: "")
            .drive(self.coinDetailView.stockNameLabel.rx.text)
            .disposed(by: self.disposeBag)
        
        reactor.state
            .map { $0.isSaveButtonEnable }
            .distinctUntilChanged()
            .asDriver(onErrorJustReturn: false)
            .drive(self.coinDetailView.saveButton.rx.isEnabled)
            .disposed(by: self.disposeBag)
        
        reactor.state
            .map { $0.avgPrice }
            .distinctUntilChanged()
            .asDriver(onErrorJustReturn: 0)
            .drive(self.coinDetailView.rx.avgPrice)
            .disposed(by: self.disposeBag)
        
        reactor.state
            .map { $0.amount }
            .distinctUntilChanged()
            .asDriver(onErrorJustReturn: 0)
            .drive(self.coinDetailView.rx.amount)
            .disposed(by: self.disposeBag)
        
        reactor.state
            .map { $0.totalPrice }
            .asDriver(onErrorJustReturn: 0)
            .drive(self.coinDetailView.rx.totalPrice)
            .disposed(by: self.disposeBag)
        
        reactor.state
            .map { $0.isSaveButtonEnable }
            .asDriver(onErrorJustReturn: false)
            .drive(self.coinDetailView.rx.isSaveEnable)
            .disposed(by: self.disposeBag)
    }
    
    private func popViewController() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func dismiss() {
        DispatchQueue.main.async { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }
    }
    
    private func setupKeyboardNotification() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    private func pop(isAlertShow: Bool) {
        if isAlertShow {
            let detailAlertViewController = DetailAlertViewController.instance().then {
                $0.onExit = { [weak self] in
                    self?.navigationController?.popViewController(animated: true)
                }
            }
            
            self.present(detailAlertViewController, animated: true, completion: nil)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    private func close(isAlertShow: Bool) {
        if isAlertShow {
            let detailAlertViewController = DetailAlertViewController.instance().then {
                $0.onExit = { [weak self] in
                    self?.dismiss()
                }
            }
            
            self.present(detailAlertViewController, animated: true, completion: nil)
        } else {
            self.dismiss()
        }
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo as? [String: Any] else { return }
        guard let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardScreenEndFrame = keyboardFrame.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        let bottomInset = UIApplication.shared.windows[0].safeAreaInsets.top
        
        self.coinDetailView.saveButton.transform = .init(
            translationX: 0,
            y: -keyboardViewEndFrame.height + bottomInset)
        self.coinDetailView.scrollView.contentInset.bottom = keyboardViewEndFrame.height
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        self.coinDetailView.saveButton.transform = .identity
        self.coinDetailView.scrollView.contentInset.bottom = .zero
    }
}
