//
//  UnsplashService.swift
//  FakeUnsplash
//
//  Created by cuong on 9/11/19.
//  Copyright © 2019 cuong. All rights reserved.
//

import Foundation
import Moya
import PromiseKit
import ObjectMapper

final class UnsplashService {
    public var provider: MoyaProvider<UnsplashTargetType>
    
    init(provider: MoyaProvider<UnsplashTargetType>) {
        self.provider = provider
    }
    
}

extension UnsplashService: UnsplashApi {
    func token(clientID: String, clientSecret: String, redirectUri: String, code: String, grantType: String) -> Promise<UnsplashEntities.TokenResponse> {
        return Promise<UnsplashEntities.TokenResponse> {seal in
            promiseRequest(.token(clientID: clientID, clientSecret: clientSecret, redirectUri: redirectUri, code: code, grantType: grantType))
                .done({ (result) in
                    print(result)
//                    seal.fulfill(UnsplashEntities.?)
                })
            .catch(seal.reject)
        }
    }
    
    
    func authorize(clientID: String, redirectUri: String, responseType: String, scope: String) -> Promise<Bool> {
        return Promise<Bool> {seal in
            promiseRequest(.authorize(clientID: clientID, redirectUri: redirectUri, responseType: responseType, scope: scope))
                .done({ (result) in
                    print(result)
                    //                    seal.fulfill(UnsplashEntities.?)
                })
            .catch(seal.reject)
        }
    }
    
    func listPhoto(page: Int, perPage: Int, orderBy: UnsplashTargetType.OrderBy) -> Promise<Array<UnsplashEntities.PhotoEntity>> {
        typealias T = Array<UnsplashEntities.PhotoEntity>
        return Promise<T> {seal in
            promiseRequest(.listPhoto(page: page, perPage: perPage, orderBy: orderBy))
                .done({ (result) in
                    let apiResponse: T = try Mapper<UnsplashEntities.PhotoEntity>().mapArray(JSONString: result.mapString())
                })
            .catch(seal.reject)
        }
    }
    
}


extension UnsplashService {
    func promiseRequest(_ target: UnsplashTargetType) -> Promise<Response> {
        return Promise<Response> {seal in
            provider.request(target) { result in
                switch result {
                case .success(let data):
                    seal.fulfill(data);
                    break;
                case .failure(let error):
                    seal.reject(error)
                    break;
                }
            }
        }
        
    }
}
