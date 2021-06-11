//
//  BaseReactorProtocol.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/05/04.
//

import RxSwift
import RxCocoa
import ReactorKit

protocol BaseReactorProtocol {
    
    func handleDefaultError(error: Error) -> Observable<String>
}

extension BaseReactorProtocol {
    
    func handleDefaultError(error: Error) -> Observable<String> {
        if let httpError = error as? HTTPError {
            return Observable.just(httpError.description)
        } else if let commonError = error as? CommonError {
            return Observable.just(commonError.message)
        } else {
            return Observable.just(error.localizedDescription)
        }
    }
}
