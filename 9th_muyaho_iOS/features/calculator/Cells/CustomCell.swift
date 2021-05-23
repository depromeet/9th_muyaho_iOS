//
//  CustomCell.swift
//  9th_muyaho_iOS
//
//  Created by 이현호 on 2021/05/22.
//

import UIKit

final class CustomCell: UICollectionViewCell {
    
    private let tabbarList: [String] = ["기록", "수익률", "물타기"]
    var label: UILabel = {
        let label = UILabel()
        label.text = "Tab"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override var isSelected: Bool {
        didSet{
            self.label.textColor = isSelected ? .white : .lightGray
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addSubview(label)
        label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    func setDisplay(index: Int) {
        label.text = tabbarList[index]
    }
}
