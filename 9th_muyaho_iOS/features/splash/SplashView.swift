//
//  SplashView.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/06/06.
//

import UIKit
import Lottie

class SplashView: BaseView {
    
    let lottieView = AnimationView().then {
        $0.contentMode = .scaleAspectFill
        $0.animation = Animation.named("splash")
    }
    
    
    override func setup() {
        self.backgroundColor = .sub_black_b1
        self.addSubview(lottieView)
    }
    
    override func bindConstraints() {
        self.lottieView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
        }
    }
}
