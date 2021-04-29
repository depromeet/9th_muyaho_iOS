//
//  BaseView.swift
//  9th_muyaho_iOS
//
//  Created by 이현호 on 2021/04/13.
//

import UIKit
import SnapKit
import RxSwift
import Then

class BaseView: UIView {
    
    var disposeBag = DisposeBag()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setup()
        self.bindConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() { }
    
    func bindConstraints() { }
}
