//
//  MyPageViewController.swift
//  9th_muyaho_iOS
//
//  Created by 이현호 on 2021/05/09.
//

import RxSwift
import ReactorKit

class MyPageViewController: BaseViewController, View {
    
    private let myPageView = MyPageView()
    private let myPageReactor = MyPageReactor(
        userDefaults: UserDefaultsUtils(),
        memberService: MembershipService(),
        kakaoSignManager: KakaoSignInManager()
    )

    
    static func instance() -> MyPageViewController {
        let myPageViewController = MyPageViewController(nibName: nil, bundle: nil)
        let tabIconOff = UIImage.icMyPageOff
        let tabIconOn = UIImage.icMyPageOn
        
        tabIconOn?.withRenderingMode(.alwaysOriginal)
        tabIconOff?.withRenderingMode(.alwaysOriginal)
        let tabBarItem = UITabBarItem(
            title: nil,
            image: tabIconOff,
            selectedImage: tabIconOn
        )
        tabBarItem.tag = TabbarTag.mypage.rawValue
        myPageViewController.tabBarItem = tabBarItem
        return myPageViewController
    }
    
    override func loadView() {
        self.view = self.myPageView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.reactor = myPageReactor
        self.myPageReactor.action.onNext(.viewDidLoad)
    }
    
    override func bindEvent() {
        self.myPageReactor.goToSignInPublisher
            .asDriver(onErrorJustReturn: ())
            .drive(onNext: self.goToSignIn)
            .disposed(by: self.eventDisposeBag)
        
        self.myPageView.withdrawalButton.rx.tap
            .asDriver()
            .drive(onNext: self.showWithdrawalAlert)
            .disposed(by: self.eventDisposeBag)
    }
    
    func bind(reactor: MyPageReactor) {
        // MARK: Bind Action
        self.myPageView.signOutButton.rx.tap
            .map { Reactor.Action.tapSignout }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        // MARK: Bind State
        reactor.state
            .map { $0.member }
            .asDriver(onErrorJustReturn: MemberInfoResponse())
            .drive(self.myPageView.rx.member)
            .disposed(by: self.disposeBag)
        
        reactor.state
            .map { $0.alertMessage }
            .compactMap { $0 }
            .distinctUntilChanged()
            .bind(onNext: self.showAlert(message:))
            .disposed(by: self.disposeBag)
    }
    
    private func goToSignIn() {
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            sceneDelegate.goToSignIn()
        }
    }
    
    private func showWithdrawalAlert() {
        AlertUtils.showWithCancel(
            viewController: self,
            title: "회원 탈퇴",
            message: "탈퇴하게되면 저장해둔 투자 종목이 모두 날아가버려요.\n그래도 탈퇴하시겠어요..?😭"
        ) { [weak self] in
            self?.myPageReactor.action.onNext(.tapWithdrawal)
        }
    }
}
