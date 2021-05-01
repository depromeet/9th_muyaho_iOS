//
//  SignInManagerProtocol.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/04/29.
//

import RxSwift

protocol SigninManagerProtocol {
    
    var publisher: PublishSubject<AuthRequest> { get }
    
    func signIn() -> Observable<AuthRequest>
}
