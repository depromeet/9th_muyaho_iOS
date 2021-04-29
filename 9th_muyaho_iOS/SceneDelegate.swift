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
        
        window = UIWindow(frame: scene.coordinateSpace.bounds)
        window?.windowScene = scene
        window?.rootViewController = SignInViewController.instance()
        window?.makeKeyAndVisible()
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            if AuthApi.isKakaoTalkLoginUrl(url) {
                _ = AuthController.rx.handleOpenUrl(url: url)
            }
        }
    }

}

