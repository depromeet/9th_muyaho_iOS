//
//  SplashViewController.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/06/06.
//

import UIKit

class SplashViewController: BaseViewController {
    
    private let splashView = SplashView()
    
    
    static func instance() -> SplashViewController {
        return SplashViewController(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        self.view = splashView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.splashView.lottieView.play()
        self.splashView.lottieView.play { [weak self] isCompleted in
            if isCompleted {
                self?.checkAuth()
            }
        }
    }
    
    private func checkAuth() {
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            sceneDelegate.checkAuth()
        }
    }
}
