//
//  ShareReactor.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/06/09.
//

import RxSwift
import RxCocoa
import ReactorKit
import Photos

class ShareReactor: Reactor {
    
    enum Action {
        case plRate(Double)
        case tapShareButton
    }
    
    enum Mutation {
        case setPLRate(Double)
        case setAsset(Double)
        case savePhoto
        case setAlertMessage(String)
    }
    
    struct State {
        var plRate: Double
        var asset: Double
    }
    
    let initialState: State
    let initialAsset: Double
    let photoPublisher = PublishRelay<Void>()
    let alertPublisher = PublishRelay<String>()
    
    init(plRate: Double, asset: Double) {
        self.initialAsset = asset
        self.initialState = State(plRate: plRate, asset: asset * ((plRate / 100) + 1))
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .plRate(let plRate):
            let expectedAsset = self.initialAsset * ((plRate / 100) + 1)
            
            return .concat([
                .just(.setAsset(expectedAsset)),
                .just(.setPLRate(plRate))
            ])
        case .tapShareButton:
            return self.getCurrentPhotosPermission()
                .flatMap { isGranged -> Observable<Mutation> in
                    if isGranged {
                        return .just(.savePhoto)
                    } else {
                        return self.requestPhotoPermission()
                            .flatMap { _ -> Observable<Mutation> in
                                return .just(.savePhoto)
                            }
                    }
                }
                .catchError(self.handleError(error:))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .setAsset(let asset):
            newState.asset = asset
        case .setPLRate(let plRate):
            newState.plRate = plRate
        case .savePhoto:
            self.photoPublisher.accept(())
        case .setAlertMessage(let message):
          self.alertPublisher.accept(message)
        }
        
        return newState
    }
    
    func getCurrentPhotosPermission() -> Observable<Bool> {
      let photoAuthorizationStatusStatus = PHPhotoLibrary.authorizationStatus()
      
      switch photoAuthorizationStatusStatus {
      case .authorized:
        return .just(true)
      case .denied:
        let deniedError = CommonError.custom("share_photo_deny_message".localized)
        
        return .error(deniedError)
      case .notDetermined:
        return .just(false)
      case .restricted:
        let restrictedError = CommonError.custom("share_photo_deny_message".localized)
        
        return .error(restrictedError)
      default:
        let unSupportedTypeError = CommonError.custom("\(photoAuthorizationStatusStatus) is not supported")
        
        return .error(unSupportedTypeError)
      }
    }
    
    private func requestPhotoPermission() -> Observable<Void> {
      return Observable.create { observer in
        PHPhotoLibrary.requestAuthorization() { status in
          switch status {
          case .authorized:
            observer.onNext(())
            observer.onCompleted()
          case .denied:
            let deniedError = CommonError.custom("share_photo_deny_message".localized)
            
            observer.onError(deniedError)
          default:
            let unSupportedTypeError = CommonError.custom("\(status) is not supported")
            
            observer.onError(unSupportedTypeError)
          }
        }
        
        return Disposables.create()
      }
    }
    
    private func handleError(error: Error) -> Observable<Mutation> {
      if let commonError = error as? CommonError {
        return .just(.setAlertMessage(commonError.message))
      } else{
        return .just(.setAlertMessage(error.localizedDescription))
      }
    }
}
