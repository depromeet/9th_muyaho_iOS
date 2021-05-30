//
//  WriteDetailViewController.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/05/29.
//

import UIKit
import ReactorKit

class WriteDomesticDetailViewController: BaseViewController, View {
    
    private let writeDomesticDetailView = WriteDomesticDetailView()
    private let writeDomesticDetailReactor: WriteDomesticDetailReactor
    
    
    init(stock: Stock) {
        self.writeDomesticDetailReactor = WriteDomesticDetailReactor(
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
    
    static func make(stock: Stock) -> WriteDomesticDetailViewController {
        return WriteDomesticDetailViewController(stock: stock)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.reactor = self.writeDomesticDetailReactor
        self.setupKeyboardNotification()
    }
    
    override func setupView() {
        self.view.addSubview(writeDomesticDetailView)
        self.writeDomesticDetailView.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
    }
    
    override func bindEvent() {
        self.writeDomesticDetailView.tapBackground.rx.event
            .map { _ in Void() }
            .asDriver(onErrorJustReturn: Void())
            .drive(onNext: self.writeDomesticDetailView.hideKeyboard)
            .disposed(by: self.eventDisposeBag)
        
        self.writeDomesticDetailView.backButton.rx.tap
            .asDriver()
            .drive(onNext: self.popViewController)
            .disposed(by: self.eventDisposeBag)
        
        self.writeDomesticDetailView.closeButton.rx.tap
            .asDriver()
            .drive(onNext: self.dismiss)
            .disposed(by: self.eventDisposeBag)
        
        self.writeDomesticDetailReactor.dismissPublisher
            .asDriver(onErrorJustReturn: ())
            .drive(onNext: self.dismiss)
            .disposed(by: self.eventDisposeBag)
        
        self.writeDomesticDetailReactor.alertPublisher
            .asDriver(onErrorJustReturn: "")
            .drive(onNext: self.showAlert(message:))
            .disposed(by: self.eventDisposeBag)
    }
    
    func bind(reactor: WriteDomesticDetailReactor) {
        // MARK: Bind Action
        self.writeDomesticDetailView.avgPriceField.rx.text
            .map { Reactor.Action.avgPrice(Double($0.replacingOccurrences(of: ",", with: "")) ?? 0) }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        self.writeDomesticDetailView.amountField.rx.text
            .map { Reactor.Action.amount(Int($0.replacingOccurrences(of: " 개", with: "")) ?? 0) }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        self.writeDomesticDetailView.saveButton.rx.tap
            .map { Reactor.Action.tapSaveButton }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        // MARK: Bind State
        reactor.state
            .map { $0.stockType }
            .asDriver(onErrorJustReturn: .domestic)
            .drive(self.writeDomesticDetailView.rx.stockType)
            .disposed(by: self.disposeBag)
        
        reactor.state
            .map { $0.stockName }
            .asDriver(onErrorJustReturn: "")
            .drive(self.writeDomesticDetailView.stockNameLabel.rx.text)
            .disposed(by: self.disposeBag)
        
        reactor.state
            .map { $0.isSaveButtonEnable }
            .distinctUntilChanged()
            .asDriver(onErrorJustReturn: false)
            .drive(self.writeDomesticDetailView.saveButton.rx.isEnabled)
            .disposed(by: self.disposeBag)
        
        reactor.state
            .map { $0.avgPrice }
            .distinctUntilChanged()
            .asDriver(onErrorJustReturn: 0)
            .drive(self.writeDomesticDetailView.rx.avgPrice)
            .disposed(by: self.disposeBag)
        
        reactor.state
            .map { $0.amount }
            .distinctUntilChanged()
            .asDriver(onErrorJustReturn: 0)
            .drive(self.writeDomesticDetailView.rx.amount)
            .disposed(by: self.disposeBag)
        
        reactor.state
            .map { $0.totalPrice }
            .asDriver(onErrorJustReturn: 0)
            .drive(self.writeDomesticDetailView.rx.totalPrice)
            .disposed(by: self.disposeBag)
        
        reactor.state
            .map { $0.isSaveButtonEnable }
            .asDriver(onErrorJustReturn: false)
            .drive(self.writeDomesticDetailView.rx.isSaveEnable)
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
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo as? [String: Any] else { return }
        guard let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardScreenEndFrame = keyboardFrame.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        let bottomInset = UIApplication.shared.windows[0].safeAreaInsets.top
        
        self.writeDomesticDetailView.saveButton.transform = .init(
            translationX: 0,
            y: -keyboardViewEndFrame.height + bottomInset)
        self.writeDomesticDetailView.scrollView.contentInset.bottom = keyboardViewEndFrame.height
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        self.writeDomesticDetailView.saveButton.transform = .identity
        self.writeDomesticDetailView.scrollView.contentInset.bottom = .zero
    }
}
