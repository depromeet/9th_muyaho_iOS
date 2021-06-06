//
//  WriteDetailViewController.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/05/29.
//

import UIKit
import ReactorKit

class DomesticDetailViewController: BaseViewController, View {
    
    private let domesticDetailView = DomesticDetailView()
    private let domesticDetailReactor: DomesticDetailReactor
    
    
    init(stock: Stock) {
        self.domesticDetailReactor = DomesticDetailReactor(
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
    
    static func make(stock: Stock) -> DomesticDetailViewController {
        return DomesticDetailViewController(stock: stock)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.reactor = self.domesticDetailReactor
        self.setupKeyboardNotification()
    }
    
    override func setupView() {
        self.view.addSubview(domesticDetailView)
        self.domesticDetailView.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
    }
    
    override func bindEvent() {
        self.domesticDetailView.tapBackground.rx.event
            .map { _ in Void() }
            .asDriver(onErrorJustReturn: Void())
            .drive(onNext: self.domesticDetailView.hideKeyboard)
            .disposed(by: self.eventDisposeBag)
        
        self.domesticDetailReactor.dismissPublisher
            .asDriver(onErrorJustReturn: ())
            .do(onNext: self.refreshWhenClose)
            .drive(onNext: self.dismiss)
            .disposed(by: self.eventDisposeBag)
        
        self.domesticDetailReactor.alertPublisher
            .asDriver(onErrorJustReturn: "")
            .drive(onNext: self.showAlert(message:))
            .disposed(by: self.eventDisposeBag)
        
        self.domesticDetailReactor.backPublisher
            .asDriver(onErrorJustReturn: true)
            .drive(onNext: self.pop(isAlertShow:))
            .disposed(by: self.eventDisposeBag)
        
        self.domesticDetailReactor.closePublisher
            .asDriver(onErrorJustReturn: true)
            .drive(onNext: self.close(isAlertShow:))
            .disposed(by: self.eventDisposeBag)
    }
    
    func bind(reactor: DomesticDetailReactor) {
        // MARK: Bind Action
        self.domesticDetailView.backButton.rx.tap
            .map { Reactor.Action.tapBack }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        self.domesticDetailView.closeButton.rx.tap
            .map { Reactor.Action.tapClose }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        self.domesticDetailView.avgPriceField.rx.text
            .map { Reactor.Action.avgPrice(Double($0.replacingOccurrences(of: ",", with: "")) ?? 0) }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        self.domesticDetailView.amountField.rx.text
            .map { Reactor.Action.amount(Int($0.replacingOccurrences(of: " 개", with: "")) ?? 0) }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        self.domesticDetailView.saveButton.rx.tap
            .map { Reactor.Action.tapSaveButton }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        // MARK: Bind State
        reactor.state
            .map { $0.stockType }
            .asDriver(onErrorJustReturn: .domestic)
            .drive(self.domesticDetailView.rx.stockType)
            .disposed(by: self.disposeBag)
        
        reactor.state
            .map { $0.stockName }
            .asDriver(onErrorJustReturn: "")
            .drive(self.domesticDetailView.stockNameLabel.rx.text)
            .disposed(by: self.disposeBag)
        
        reactor.state
            .map { $0.isSaveButtonEnable }
            .distinctUntilChanged()
            .asDriver(onErrorJustReturn: false)
            .drive(self.domesticDetailView.saveButton.rx.isEnabled)
            .disposed(by: self.disposeBag)
        
        reactor.state
            .map { $0.avgPrice }
            .distinctUntilChanged()
            .asDriver(onErrorJustReturn: 0)
            .drive(self.domesticDetailView.rx.avgPrice)
            .disposed(by: self.disposeBag)
        
        reactor.state
            .map { $0.amount }
            .distinctUntilChanged()
            .asDriver(onErrorJustReturn: 0)
            .drive(self.domesticDetailView.rx.amount)
            .disposed(by: self.disposeBag)
        
        reactor.state
            .map { $0.totalPrice }
            .asDriver(onErrorJustReturn: 0)
            .drive(self.domesticDetailView.rx.totalPrice)
            .disposed(by: self.disposeBag)
        
        reactor.state
            .map { $0.isSaveButtonEnable }
            .asDriver(onErrorJustReturn: false)
            .drive(self.domesticDetailView.rx.isSaveEnable)
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
            let detailAlertViewController = DetailAlertViewController.instance(type: .detail).then {
                $0.onExit = { [weak self] in
                    self?.navigationController?.popViewController(animated: true)
                }
            }
            
            self.present(detailAlertViewController, animated: true, completion: nil)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    private func refreshWhenClose() {
        for vc in self.navigationController!.viewControllers {
            if let writeNewStockTypeViewController = vc as? WriteNewStockTypeViewController {
                writeNewStockTypeViewController.delegate?.onFinishWrite()
            }
        }
    }
    
    private func close(isAlertShow: Bool) {
        if isAlertShow {
            let detailAlertViewController = DetailAlertViewController.instance(type: .detail).then {
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
        
        self.domesticDetailView.saveButton.transform = .init(
            translationX: 0,
            y: -keyboardViewEndFrame.height + bottomInset)
        self.domesticDetailView.scrollView.contentInset.bottom = keyboardViewEndFrame.height
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        self.domesticDetailView.saveButton.transform = .identity
        self.domesticDetailView.scrollView.contentInset.bottom = .zero
    }
}
