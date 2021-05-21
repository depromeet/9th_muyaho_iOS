//
//  SearchStockViewController.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/05/21.
//

import UIKit

class SearchStockViewController: BaseViewController {
    
    let searchStockView = SearchStockView()
    
    
    static func instance() -> SearchStockViewController {
        return SearchStockViewController(nibName: nil, bundle: nil).then {
            $0.modalPresentationStyle = .overCurrentContext
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func setupView() {
        self.view.addSubview(searchStockView)
        self.searchStockView.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
    }
    
    override func bindEvent() {
        self.searchStockView.closeButton.rx.tap
            .asDriver()
            .drive(onNext: self.dismiss)
            .disposed(by: self.eventDisposeBag)
    }
    
    private func dismiss() {
        self.dismiss(animated: true, completion: nil)
    }
}
