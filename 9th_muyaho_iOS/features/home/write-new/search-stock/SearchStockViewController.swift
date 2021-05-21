//
//  SearchStockViewController.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/05/21.
//

import UIKit

class SearchStockViewController: BaseViewController {
    
    private let searchStockView = SearchStockView()
    
    
    static func instance() -> SearchStockViewController {
        return SearchStockViewController(nibName: nil, bundle: nil)
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
}
