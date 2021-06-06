//
//  SceneDelegate.swift
//  9th_muyaho_iOS
//
//  Created by 이현호 on 2021/04/13.
//

import UIKit
import RxKakaoSDKAuth
import KakaoSDKAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = (scene as? UIWindowScene) else { return }
        
        self.window = UIWindow(frame: scene.coordinateSpace.bounds)
        self.window?.windowScene = scene
        
        self.window?.rootViewController = SplashViewController.instance()
        self.window?.makeKeyAndVisible()
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            if AuthApi.isKakaoTalkLoginUrl(url) {
                _ = AuthController.rx.handleOpenUrl(url: url)
            }
        }
    }
    
    func goToSignIn() {
        let signInViewController = SignInViewController.instance()
        let navigationController = UINavigationController(rootViewController: signInViewController).then {
            $0.setNavigationBarHidden(true, animated: false)
        }
        
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
    }
    
    func goToMain() {
        let tabBarController = MainTabBerController()
        
        self.window?.rootViewController = tabBarController
        self.window?.makeKeyAndVisible()
    }
    
    func checkAuth() {
        if UserDefaultsUtils().sessionId.isEmpty {
            self.goToSignIn()
        } else {
            self.goToMain()
        }
    }
}

