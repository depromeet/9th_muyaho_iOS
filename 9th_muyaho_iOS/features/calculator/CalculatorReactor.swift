//
//  CalculatorReactor.swift
//  9th_muyaho_iOS
//
//  Created by 이현호 on 2021/05/22.
//

import ReactorKit

class CalculatorReactor: Reactor {
    
    enum Action {
        case tapRefreshButton(Void)
    }
    
    enum Mutation {
        case changeTitle(String)
    }
    
    struct State {
        var title: String = "어써오세이요."
    }
    
    let initialState = State()
    
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .tapRefreshButton(()):
            return Observable.just(Mutation.changeTitle(self.randomString()))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .changeTitle(let title):
            newState.title = title
        }
        
        return newState
    }
    
    private func randomString() -> String {
        let stringArray = [
            "아뇽하세요.",
            "무야호~~~",
            "우리조 완성시켜봅시다.",
            "아울러 다른분들 화이팅!"
        ]
        guard let randomString = stringArray.randomElement() else { return "" }
        
        return randomString
    }
}
