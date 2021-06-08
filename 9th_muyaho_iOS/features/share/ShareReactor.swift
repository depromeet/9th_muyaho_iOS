//
//  ShareReactor.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/06/09.
//

import RxSwift
import RxCocoa
import ReactorKit

class ShareReactor: Reactor {
    
    enum Action {
        case plRate(Double)
        case tapShareButton
    }
    
    enum Mutation {
        case setPLRate(Double)
        case setAsset(Double)
    }
    
    struct State {
        var plRate: Double
        var asset: Double
    }
    
    let initialState: State
    let photoPublisher = PublishRelay<Void>()
    
    init(plRate: Double, asset: Double) {
        self.initialState = State(plRate: plRate, asset: asset)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .plRate(let plRate):
            return .just(.setPLRate(plRate))
        case .tapShareButton:
            return .empty()
        }
    }
}
