//
//  AllApi.swift
//  FakeUnsplash
//
//  Created by Trần Tý on 9/12/19.
//  Copyright © 2019 cuong. All rights reserved.
//

import Foundation
import Moya
import PromiseKit

protocol UnsplashApi {
    
    // MARK: - Authorization
    func authorize(clientID: String, redirectUri: String, responseType: String, scope: String) -> Promise<Bool>
    func token(clientID: String, clientSecret: String,  redirectUri: String, code: String, grantType: String) -> Promise<UnsplashEntities.TokenResponse>
    //
    func listPhoto(page: Int, perPage: Int, orderBy: UnsplashTargetType.OrderBy) -> Promise<Array<UnsplashEntities.PhotoEntity>>
}
