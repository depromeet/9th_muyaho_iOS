//
//  StockDetailChildViewController.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/06/05.
//

import UIKit

class StockDetailChildViewController: BaseViewController {
    
    private let stockDetailChildView = StockDetailChildView()
    
    static func instance() -> StockDetailChildViewController {
        return StockDetailChildViewController(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        self.view = stockDetailChildView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.stockDetailChildView.tableView.dataSource = self
    }
}

extension StockDetailChildViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: StockDetailOverviewCell.registerId,
                    for: indexPath
            ) as? StockDetailOverviewCell else { return BaseTableViewCell() }
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: StockDetailItemCell.registerId,
                    for: indexPath
            ) as? StockDetailItemCell else { return BaseTableViewCell() }
            
            return cell
        }
    }
}
