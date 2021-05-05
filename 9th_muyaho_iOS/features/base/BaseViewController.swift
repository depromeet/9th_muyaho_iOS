//
//  BaseViewController.swift
//  9th_muyaho_iOS
//
//  Created by 이현호 on 2021/04/13.
//

import UIKit
import RxSwift
import RxCocoa

class BaseViewController: UIViewController {
    
    var disposeBag = DisposeBag()
    let eventDisposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupView()
        self.bindEvent()
    }
    
    func setupView() { }
    
    func bindEvent() { }
    
    func showAlert(message: String) {
        AlertUtils.show(viewController: self, title: nil, message: message)
    }
}
