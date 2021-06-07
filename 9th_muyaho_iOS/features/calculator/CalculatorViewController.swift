//
//  CalculatorVIewController.swift
//  9th_muyaho_iOS
//
//  Created by 이현호 on 2021/05/22.
//

import RxSwift
import ReactorKit

class CalculatorViewController: BaseViewController {
    
    private let calculatorView = CalculatorView()
    
    
    static func instance() -> CalculatorViewController {
        let calculatorViewController = CalculatorViewController(nibName: nil, bundle: nil)
        let tabIconOff = UIImage.icCalculateOff
        let tabIconOn = UIImage.icCalculateOn
        
        tabIconOn?.withRenderingMode(.alwaysOriginal)
        tabIconOff?.withRenderingMode(.alwaysOriginal)
        let tabBarItem = UITabBarItem(
            title: nil,
            image: tabIconOff,
            selectedImage: tabIconOn
        )
        
        tabBarItem.tag = TabbarTag.calculater.rawValue
        calculatorViewController.tabBarItem = tabBarItem
        return calculatorViewController
    }
    
    override func loadView() {
        self.view = self.calculatorView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.calculatorView.startSlimeAnimation()
    }
}
