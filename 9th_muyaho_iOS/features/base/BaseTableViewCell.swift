//
//  BaseTableViewCell.swift
//  9th_muyaho_iOS
//
//  Created by 이현호 on 2021/04/13.
//

import UIKit
import RxSwift

class BaseTableViewCell: UITableViewCell {
    
    var disposeBag = DisposeBag()
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.disposeBag = DisposeBag()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.setup()
        self.bindConstraints()
    }
    
    func setup() { }
    
    func bindConstraints() { }
}
