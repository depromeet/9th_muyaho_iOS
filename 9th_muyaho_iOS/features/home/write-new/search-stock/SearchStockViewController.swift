//
//  SearchStockViewController.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/05/21.
//

import UIKit
import ReactorKit

protocol SearchStockDelegate: AnyObject {
    
    func onSelectStock(stock: Stock)
}

class SearchStockViewController: BaseViewController, View {
    
    let searchStockView = SearchStockView()
    weak var delegate: SearchStockDelegate?
    private let searchStockReactor: SearchStockReactor
    
    
    init(stockType: StockType) {
        self.searchStockReactor = SearchStockReactor(
            stockType: stockType,
            stockService: StockService(),
            userDefaults: UserDefaultsUtils()
        )
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func instance(stockType: StockType) -> SearchStockViewController {
        return SearchStockViewController(stockType: stockType).then {
            $0.modalPresentationStyle = .overCurrentContext
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.reactor = self.searchStockReactor
        let _ = self.searchStockView.searchStockField.becomeFirstResponder()
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
    
    func bind(reactor: SearchStockReactor) {
        // MARK: Bind Action
        self.searchStockView.searchStockField.rx.text.orEmpty
            .map { Reactor.Action.inputKeyword($0) }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        self.searchStockView.stockTableView.rx.itemSelected
            .map { Reactor.Action.selectStock($0.row) }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        // MARK: Bind State
        reactor.state
            .map { $0.searchedStocks }
            .bind(to: self.searchStockView.stockTableView.rx.items(
                    cellIdentifier: SearchCell.reusableIdentifier,
                    cellType: SearchCell.self
            )) { row, stock, cell in
                cell.bind(stock: stock, type: .normal)
            }
            .disposed(by: self.disposeBag)
        
        reactor.goWriteDetailPublisher
            .observeOn(MainScheduler.instance)
            .bind(onNext: self.goWriteDetail(stock:))
            .disposed(by: self.disposeBag)
    }
    
    private func dismiss() {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func goWriteDetail(stock: Stock) {
        self.dismiss(animated: false) { [weak self] in
            self?.delegate?.onSelectStock(stock: stock)
        }
    }
}
