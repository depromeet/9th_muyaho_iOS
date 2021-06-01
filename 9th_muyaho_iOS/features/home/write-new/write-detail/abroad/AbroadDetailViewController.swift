//
//  AbroadDetailViewController.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/06/01.
//

import UIKit
import ReactorKit

class AbroadDetailViewController: BaseViewController, View {
    
    private let abroadDetailView = AbroadDetailView()
    private let abroadDetailReactor: AbroadDetailReactor
    
    init(stock: Stock) {
        self.abroadDetailReactor = AbroadDetailReactor(
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
    
    static func make(stock: Stock) -> AbroadDetailViewController {
        return AbroadDetailViewController(stock: stock)
    }
    
    override func loadView() {
        self.view = abroadDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.reactor = self.abroadDetailReactor
        self.setupKeyboardNotification()
    }
    
    override func bindEvent() {
        self.abroadDetailView.tapBackground.rx.event
            .map { _ in Void() }
            .asDriver(onErrorJustReturn: Void())
            .drive(onNext: self.abroadDetailView.hideKeyboard)
            .disposed(by: self.eventDisposeBag)
        
        self.abroadDetailReactor.dismissPublisher
            .asDriver(onErrorJustReturn: ())
            .drive(onNext: self.dismiss)
            .disposed(by: self.eventDisposeBag)

        self.abroadDetailReactor.alertPublisher
            .asDriver(onErrorJustReturn: "")
            .drive(onNext: self.showAlert(message:))
            .disposed(by: self.eventDisposeBag)

        self.abroadDetailReactor.backPublisher
            .asDriver(onErrorJustReturn: true)
            .drive(onNext: self.pop(isAlertShow:))
            .disposed(by: self.eventDisposeBag)

        self.abroadDetailReactor.closePublisher
            .asDriver(onErrorJustReturn: true)
            .drive(onNext: self.close(isAlertShow:))
            .disposed(by: self.eventDisposeBag)
    }
    
    func bind(reactor: AbroadDetailReactor) {
        // MARK: Bind Action
        self.abroadDetailView.backButton.rx.tap
            .map { Reactor.Action.tapBack }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        self.abroadDetailView.closeButton.rx.tap
            .map { Reactor.Action.tapClose }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        self.abroadDetailView.avgPriceField.rx.text
            .map { text in
                let removeUnit = text.replacingOccurrences(of: " USD", with: "")
                let removeComma = removeUnit.replacingOccurrences(of: ",", with: "")
                
                return Reactor.Action.avgPrice(Double(removeComma) ?? 0)
            }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        self.abroadDetailView.purchasedMoneyField.rx.text
            .map { message in
                let removeUnit = message.replacingOccurrences(of: " 원", with: "")
                let removeComma = removeUnit.replacingOccurrences(of: ",", with: "")
                
                return Reactor.Action.purchasedMoney(Double(removeComma) ?? 0)
            }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        self.abroadDetailView.amountField.rx.text
            .map { Reactor.Action.amount(Int($0.replacingOccurrences(of: " 개", with: "")) ?? 0) }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        self.abroadDetailView.saveButton.rx.tap
            .map { Reactor.Action.tapSaveButton }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        // MARK: Bind State
        reactor.state
            .map { $0.stockType }
            .asDriver(onErrorJustReturn: .domestic)
            .drive(self.abroadDetailView.rx.stockType)
            .disposed(by: self.disposeBag)
        
        reactor.state
            .map { $0.stockName }
            .asDriver(onErrorJustReturn: "")
            .drive(self.abroadDetailView.stockNameLabel.rx.text)
            .disposed(by: self.disposeBag)
        
        reactor.state
            .map { $0.isSaveButtonEnable }
            .distinctUntilChanged()
            .asDriver(onErrorJustReturn: false)
            .drive(self.abroadDetailView.saveButton.rx.isEnabled)
            .disposed(by: self.disposeBag)
        
        reactor.state
            .map { $0.avgPrice }
            .distinctUntilChanged()
            .asDriver(onErrorJustReturn: 0)
            .drive(self.abroadDetailView.rx.avgPrice)
            .disposed(by: self.disposeBag)
        
        reactor.state
            .map { $0.amount }
            .distinctUntilChanged()
            .asDriver(onErrorJustReturn: 0)
            .drive(self.abroadDetailView.rx.amount)
            .disposed(by: self.disposeBag)
        
        reactor.state
            .map { $0.totalPrice }
            .asDriver(onErrorJustReturn: 0)
            .drive(self.abroadDetailView.rx.totalPrice)
            .disposed(by: self.disposeBag)
        
        reactor.state
            .map { $0.isSaveButtonEnable }
            .asDriver(onErrorJustReturn: false)
            .drive(self.abroadDetailView.rx.isSaveEnable)
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
        
        self.abroadDetailView.saveButton.transform = .init(
            translationX: 0,
            y: -keyboardViewEndFrame.height + bottomInset)
        self.abroadDetailView.scrollView.contentInset.bottom = keyboardViewEndFrame.height + 100
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        self.abroadDetailView.saveButton.transform = .identity
        self.abroadDetailView.scrollView.contentInset.bottom = .zero
    }
}
