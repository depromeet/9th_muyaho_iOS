//
//  BoardViewController.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/06/06.
//

import RxSwift
import RxCocoa

class BoardViewController: BaseViewController {
    
    private let boardView = BoardView()
    
    
    static func instacne() -> BoardViewController {
        let boardViewController = BoardViewController(nibName: nil, bundle: nil)
        let tabIconOff = UIImage.icBoardOff
        let tabIconOn = UIImage.icBoardOn
        
        tabIconOn?.withRenderingMode(.alwaysOriginal)
        tabIconOff?.withRenderingMode(.alwaysOriginal)
        let tabBarItem = UITabBarItem(
            title: nil,
            image: tabIconOff,
            selectedImage: tabIconOn
        )
        tabBarItem.tag = TabbarTag.board.rawValue
        boardViewController.tabBarItem = tabBarItem
        return boardViewController
    }
    
    override func loadView() {
        self.view = boardView
    }
}
