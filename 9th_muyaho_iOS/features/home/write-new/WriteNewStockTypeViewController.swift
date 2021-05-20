//
//  WriteNewStockTypeViewController.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/05/20.
//

import RxSwift

class WriteNewStockTypeViewController: BaseViewController {
    
    private let writeNewStockTypeView = WriteNewStockTypeView()
    
    
    static func instance() -> UINavigationController {
        let viewController = WriteNewStockTypeViewController(nibName: nil, bundle: nil)
        
        return UINavigationController(rootViewController: viewController).then {
            $0.modalPresentationStyle = .overCurrentContext
            $0.setNavigationBarHidden(true, animated: false)
        }
    }
    
    override func setupView() {
        self.view.addSubview(self.writeNewStockTypeView)
        self.writeNewStockTypeView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func bindEvent() {
        self.writeNewStockTypeView.closeButton.rx.tap
            .observeOn(MainScheduler.instance)
            .bind(onNext: self.dismiss)
            .disposed(by: self.eventDisposeBag)
    }
    
    private func dismiss() {
        self.dismiss(animated: true, completion: nil)
    }
}
