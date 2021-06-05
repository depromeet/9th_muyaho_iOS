//
//  StockDetailChildViewController.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/06/05.
//

import UIKit
import RxSwift
import RxCocoa
import ReactorKit
import RxDataSources

class StockDetailChildViewController: BaseViewController, View {
    
    private let stockDetailChildView = StockDetailChildView()
    private let stockDetailChildReactor: StockDetailChildReactor
    private var stockDataSource: RxTableViewSectionedReloadDataSource<StockDetailItemSection>!
    
    
    init(type: StockType, stocks: [StockCalculateResponse]) {
        self.stockDetailChildReactor = StockDetailChildReactor(
            type: type,
            stocks: stocks,
            stockService: StockService()
        )
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func instance(
        type: StockType,
        stocks: [StockCalculateResponse]
    ) -> StockDetailChildViewController {
        return StockDetailChildViewController(type: type, stocks: stocks)
    }
    
    override func loadView() {
        self.view = stockDetailChildView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupTableView()
        self.reactor = self.stockDetailChildReactor
        self.stockDetailChildReactor.action.onNext(.viewDidLoad)
    }
    
    func bind(reactor: StockDetailChildReactor) {
        // Bind State
        reactor.state
            .map { $0.stocks }
            .asDriver(onErrorJustReturn: [])
            .drive(self.stockDetailChildView.tableView.rx.items(dataSource: self.stockDataSource))
            .disposed(by: self.disposeBag)
    }
    
    private func setupTableView() {
        self.stockDataSource = RxTableViewSectionedReloadDataSource<StockDetailItemSection> { (dataSource, tableView, indexPath, item) in
            if indexPath.section == 0 {
                guard let cell = self.stockDetailChildView.tableView.dequeueReusableCell(
                    withIdentifier: StockDetailOverviewCell.registerId,
                    for: indexPath
                ) as? StockDetailOverviewCell else { return BaseTableViewCell() }
                
                let sectionModel = dataSource.sectionModels[indexPath.section]
                
                cell.bind(
                    type: sectionModel.type,
                    totalMoney: sectionModel.totalMoney,
                    pl: sectionModel.profiltOrLose
                )
                return cell
            } else {
                guard let cell = self.stockDetailChildView.tableView.dequeueReusableCell(
                    withIdentifier: StockDetailItemCell.registerId,
                    for: indexPath
                ) as? StockDetailItemCell else { return BaseTableViewCell() }
                
                cell.bind(stock: item)
                return cell
            }
        }
    }
}
