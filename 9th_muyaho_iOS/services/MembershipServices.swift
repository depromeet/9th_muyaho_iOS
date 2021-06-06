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
    
    func signIn(socialType: SocialType, authRequest: AuthRequest) -> Observable<ResponseContainer<AuthResponse>>
    
    func signUp(socialType: SocialType, authRequest: AuthRequest, name: String) -> Observable<ResponseContainer<AuthResponse>>
    
    func fetchMemberInfo() -> Observable<ResponseContainer<MemberInfoResponse>>
    
    func withdrawal() -> Observable<ResponseContainer<String>>
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
                    throw HTTPError(rawValue: response.statusCode) ?? .unknown
                }
            }
    }
    
    func signIn(socialType: SocialType, authRequest: AuthRequest) -> Observable<ResponseContainer<AuthResponse>> {
        let urlString = HTTPUtils.endPoint + "/api/v1/login/\(socialType.lowercase)"
        let parameters = authRequest.toDict()
        
        return RxAlamofire.requestJSON(
            .post,
            urlString,
            parameters: parameters,
            encoding: JSONEncoding.default
        ).expectingObject(ofType: AuthResponse.self)
    }
    
    func signUp(socialType: SocialType, authRequest: AuthRequest, name: String) -> Observable<ResponseContainer<AuthResponse>> {
        let urlString = HTTPUtils.endPoint + "/api/v1/signup/\(socialType.lowercase)"
        var parameters = authRequest.toDict()
        parameters["name"] = name
        
        return RxAlamofire.requestJSON(
            .post,
            urlString,
            parameters: parameters,
            encoding: JSONEncoding.default
        ).expectingObject(ofType: AuthResponse.self)
    }
    
    func fetchMemberInfo() -> Observable<ResponseContainer<MemberInfoResponse>> {
        let urlString = HTTPUtils.endPoint + "/api/v1/member"
        let headers = HTTPUtils.authorizationHeader()
        
        return RxAlamofire.requestJSON(
            .get,
            urlString,
            headers: headers
        ).expectingObject(ofType: MemberInfoResponse.self)
    }
    
    func withdrawal() -> Observable<ResponseContainer<String>> {
        let urlString = HTTPUtils.endPoint + "/api/v1/member"
        let headers = HTTPUtils.authorizationHeader()
        
        return RxAlamofire.requestJSON(
            .delete,
            urlString,
            headers: headers
        ).expectingObject(ofType: String.self)
    }
}
