//
//  WriteDetailViewController.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/05/29.
//

import UIKit
import ReactorKit

class WriteDetailViewController: BaseViewController, View {
    
    private let writeDetailView = WriteDetailView()
    private let writeDetailReactor: WriteDetailReactor
    
    
    init(stock: Stock) {
        self.writeDetailReactor = WriteDetailReactor(stock: stock)
        super.init(nibName: nil, bundle: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func make(stock: Stock) -> WriteDetailViewController {
        return WriteDetailViewController(stock: stock)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.reactor = self.writeDetailReactor
        self.setupKeyboardNotification()
    }
    
    override func setupView() {
        self.view.addSubview(writeDetailView)
        self.writeDetailView.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
    }
    
    override func bindEvent() {
        self.writeDetailView.tapBackground.rx.event
            .map { _ in Void() }
            .asDriver(onErrorJustReturn: Void())
            .drive(onNext: self.writeDetailView.hideKeyboard)
            .disposed(by: self.eventDisposeBag)
        
        self.writeDetailView.backButton.rx.tap
            .asDriver()
            .drive(onNext: self.popViewController)
            .disposed(by: self.eventDisposeBag)
        
        self.writeDetailView.closeButton.rx.tap
            .asDriver()
            .drive(onNext: self.dismiss)
            .disposed(by: self.eventDisposeBag)
        
        self.writeDetailReactor.dismissPublisher
            .asDriver(onErrorJustReturn: ())
            .drive(onNext: self.dismiss)
            .disposed(by: self.eventDisposeBag)
    }
    
    func bind(reactor: WriteDetailReactor) {
        // MARK: Bind Action
        self.writeDetailView.avgPriceField.rx.text
            .map { Reactor.Action.avgPrice(Double($0.replacingOccurrences(of: ",", with: "")) ?? 0) }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        self.writeDetailView.amountField.rx.text
            .map { Reactor.Action.amount(Int($0.replacingOccurrences(of: " 개", with: "")) ?? 0) }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        self.writeDetailView.saveButton.rx.tap
            .map { Reactor.Action.tapSaveButton }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        // MARK: Bind State
        reactor.state
            .map { $0.stockType }
            .asDriver(onErrorJustReturn: .domestic)
            .drive(self.writeDetailView.rx.stockType)
            .disposed(by: self.disposeBag)
        
        reactor.state
            .map { $0.stockName }
            .asDriver(onErrorJustReturn: "")
            .drive(self.writeDetailView.stockNameLabel.rx.text)
            .disposed(by: self.disposeBag)
        
        reactor.state
            .map { $0.isSaveButtonEnable }
            .distinctUntilChanged()
            .asDriver(onErrorJustReturn: false)
            .drive(self.writeDetailView.saveButton.rx.isEnabled)
            .disposed(by: self.disposeBag)
        
        reactor.state
            .map { $0.avgPrice }
            .distinctUntilChanged()
            .asDriver(onErrorJustReturn: 0)
            .drive(self.writeDetailView.rx.avgPrice)
            .disposed(by: self.disposeBag)
        
        reactor.state
            .map { $0.amount }
            .distinctUntilChanged()
            .asDriver(onErrorJustReturn: 0)
            .drive(self.writeDetailView.rx.amount)
            .disposed(by: self.disposeBag)
        
        reactor.state
            .map { $0.totalPrice }
            .asDriver(onErrorJustReturn: 0)
            .drive(self.writeDetailView.rx.totalPrice)
            .disposed(by: self.disposeBag)
        
        reactor.state
            .map { $0.isSaveButtonEnable }
            .asDriver(onErrorJustReturn: false)
            .drive(self.writeDetailView.rx.isSaveEnable)
            .disposed(by: self.disposeBag)
    }
    
    private func popViewController() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func dismiss() {
        self.dismiss(animated: true, completion: nil)
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
        
        self.writeDetailView.saveButton.transform = .init(
            translationX: 0,
            y: -keyboardViewEndFrame.height + bottomInset)
        self.writeDetailView.scrollView.contentInset.bottom = keyboardViewEndFrame.height
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        self.writeDetailView.saveButton.transform = .identity
        self.writeDetailView.scrollView.contentInset.bottom = .zero
    }
}
