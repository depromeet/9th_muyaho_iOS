//
//  ProfitrateCell.swift
//  9th_muyaho_iOS
//
//  Created by 이현호 on 2021/05/22.
//

import UIKit

class ProfitrateCell: UICollectionViewCell {

    
    @IBOutlet weak var haveAverageLabel: UITextField!
    @IBOutlet weak var haveCountLabel: UITextField!
    @IBOutlet weak var buyPriceLabel: UITextField!
    
    @IBOutlet weak var targetAmountLabel: UITextField!
    @IBOutlet weak var targetProfitrateLabel: UITextField!
    
    @IBOutlet weak var saveButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .sub_black_b1
        
        haveAverageLabel.backgroundColor = .sub_black_b3
        haveAverageLabel.textColor = .sub_gray_40
        
        haveCountLabel.backgroundColor = .sub_black_b3
        haveCountLabel.textColor = .sub_gray_40
        
        buyPriceLabel.backgroundColor = .sub_black_b3
        buyPriceLabel.textColor = .sub_gray_40
        
        targetAmountLabel.backgroundColor = .sub_black_b3
        targetAmountLabel.textColor = .sub_gray_40
        
        targetProfitrateLabel.backgroundColor = .sub_black_b3
        targetProfitrateLabel.textColor = .sub_gray_40
        
        saveButton.backgroundColor = UIColor(r: 45, g: 36, b: 125)
        saveButton.layer.cornerRadius = 8
    }

}

