//
//  AppDelegate.swift
//  9th_muyaho_iOS
//
//  Created by 이현호 on 2021/04/13.
//

import UIKit
import KakaoSDKCommon
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        self.initilizeKakao()
        self.initilizeFirebase()
        self.initializeNetworkLogger()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        return UISceneConfiguration(
            name: "Default Configuration",
            sessionRole: connectingSceneSession.role
        )
    }

    func application(
        _ application: UIApplication,
        didDiscardSceneSessions sceneSessions: Set<UISceneSession>
    ) {
    }

    private func initilizeKakao() {
      let kakaoAppKey = Bundle.main.object(forInfoDictionaryKey: "KAKAO_APP_KEY") as? String ?? ""
        
      KakaoSDKCommon.initSDK(appKey: kakaoAppKey)
    }
    
    private func initializeNetworkLogger() {
      NetworkActivityLogger.shared.startLogging()
      NetworkActivityLogger.shared.level = .debug
    }
    
    private func initilizeFirebase() {
        FirebaseApp.configure()
    }
}

