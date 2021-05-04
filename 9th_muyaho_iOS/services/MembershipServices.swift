//
//  MembershipServices.swift
//  9th_muyaho_iOS
//
//  Created by Hyun Sik Yoo on 2021/05/01.
//

import RxAlamofire
import RxSwift
import RxCocoa
import Alamofire

protocol MembershipServiceProtocol {
    
    func validateNickname(nickname: String) -> Observable<Bool>
    
    func signIn(authRequest: AuthRequest) -> Observable<ResponseContainer<AuthResponse>>
    
    func signUp(authRequest: AuthRequest, name: String) -> Observable<ResponseContainer<AuthResponse>>
}

struct MembershipService: MembershipServiceProtocol {
    
    func validateNickname(nickname: String) -> Observable<Bool> {
        let urlString = HTTPUtils.endPoint + "/api/v1/check/name"
        let parameters = ["name": nickname]
        
        return RxAlamofire.requestJSON(.get, urlString, parameters: parameters)
            .map { (response, value) in
                if response.isSuccess {
                    return true
                } else if response.statusCode == 409 {
                    return false
                } else {
                    let httpError = HTTPError(rawValue: response.statusCode)
                    
                    throw httpError ?? CommonError.custom("HTTP status code: \(response.statusCode)")
                }
            }
    }
    
    func signIn(authRequest: AuthRequest) -> Observable<ResponseContainer<AuthResponse>> {
        let urlString = HTTPUtils.endPoint + "/api/v1/login"
        let parameters = authRequest.toDict()
        
        return RxAlamofire.requestJSON(
            .post,
            urlString,
            parameters: parameters,
            encoding: JSONEncoding.default
        ).expectingObject(ofType: AuthResponse.self)
    }
    
    func signUp(authRequest: AuthRequest, name: String) -> Observable<ResponseContainer<AuthResponse>> {
        let urlString = HTTPUtils.endPoint + "/api/v1/signup"
        var parameters = authRequest.toDict()
        parameters["name"] = name
        
        return RxAlamofire.requestJSON(
            .post,
            urlString,
            parameters: parameters,
            encoding: JSONEncoding.default
        ).expectingObject(ofType: AuthResponse.self)
    }
}
