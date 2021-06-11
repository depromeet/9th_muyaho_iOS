//
//  WaterrideCell.swift
//  9th_muyaho_iOS
//
//  Created by 이현호 on 2021/05/23.
//

import UIKit

class WaterrideCell: UICollectionViewCell {

    @IBOutlet weak var haveAverageLabel: UITextField!
    @IBOutlet weak var haveCountLabel: UITextField!
    @IBOutlet weak var buyPriceLabel: UITextField!
    
    
    @IBOutlet weak var waterideHaveAverageLabel: UITextField!
    @IBOutlet weak var waterideHaveCountLabel: UITextField!
    @IBOutlet weak var waterideBuyPriceLabel: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .sub_black_b1
        
        haveAverageLabel.backgroundColor = .sub_black_b3
        haveAverageLabel.textColor = .sub_gray_40
        
        haveCountLabel.backgroundColor = .sub_black_b3
        haveCountLabel.textColor = .sub_gray_40
        
        buyPriceLabel.backgroundColor = .sub_black_b3
        buyPriceLabel.textColor = .sub_gray_40
        
        waterideHaveAverageLabel.backgroundColor = .sub_black_b3
        waterideHaveAverageLabel.textColor = .sub_gray_40
        
        waterideHaveCountLabel.backgroundColor = .sub_black_b3
        waterideHaveCountLabel.textColor = .sub_gray_40
        
        waterideBuyPriceLabel.backgroundColor = .sub_black_b3
        waterideBuyPriceLabel.textColor = .sub_gray_40
        
    }

}
