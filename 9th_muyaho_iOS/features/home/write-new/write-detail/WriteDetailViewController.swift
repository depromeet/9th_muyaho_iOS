//
//  WriteDetailViewController.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/05/29.
//

import UIKit

class WriteDetailViewController: BaseViewController {
    
    private let writeDetailView = WriteDetailView()
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    static func make() -> WriteDetailViewController {
        return WriteDetailViewController(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
