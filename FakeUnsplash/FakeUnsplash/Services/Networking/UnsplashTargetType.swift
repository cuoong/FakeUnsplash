//
//  UnsplashAPI.swift
//  FakeUnsplash
//
//  Created by cuong on 9/11/19.
//  Copyright © 2019 cuong. All rights reserved.
//

import Foundation
import Moya
import Alamofire

enum UnsplashTargetType {
    enum OrderBy: String {
        case latest, oldest, popular
    }
    
    static func readJSONFromFile(fileName: String) -> Data? {
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            
            let fileUrl = URL(fileURLWithPath: path)
            // Getting data from JSON file using the file URL
            return try? Data(contentsOf: fileUrl, options: .mappedIfSafe)
            
        }
        return nil
    }
    
    case authorize(clientID: String, redirectUri: String, responseType: String, scope: String)
    case token(clientID: String, clientSecret: String,  redirectUri: String, code: String, grantType: String)
    //
    case listPhoto(page: Int, perPage: Int, orderBy: OrderBy)
    
}
extension UnsplashTargetType: TargetType  {
    
    var baseURL: URL {
        switch self {
        case .authorize, .token:
            return URL(string: UnsplashApiConfig.AUTHORIZE_BASE_URL)!
        default:
            return URL(string: UnsplashApiConfig.BASE_URL)!
        }
    }
    
    var path: String {
        switch self {
        case .authorize:
            return "authorize"
        case .token:
            return "token"
        case .listPhoto:
            return "photos"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .listPhoto:
            return .get
        case .authorize, .token:
            return .post
        }
    }
    
    var sampleData: Data {
        switch self {
        case .listPhoto(let page, let _, let _):
            if page == -1 {
                return Data(base64Encoded: "")!
            }
            return UnsplashTargetType.readJSONFromFile(fileName: "ListPhoto")!
        default:
            return UnsplashTargetType.readJSONFromFile(fileName: "ListPhoto")!
        }
    }
    
    var task: Task {
        switch self {
        case .listPhoto(let pageIndex, let perPage, let orderBy):
            return .requestParameters(parameters: ["page": pageIndex, "per_page": perPage, "orderBy": orderBy.rawValue], encoding: URLEncoding.default)
        case .authorize(let accessKey, let redirectUri, let responseType, let scope):
            let params: [String: Any] = [
                "client_id": accessKey,
                "redirect_uri": redirectUri,
                "response_type": responseType,
                "scope": scope
            ]
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        case .token(let clientID, let clientSecret, let redirectUri, let code, let grantType):
            let params: [String: Any] = [
                "client_id": clientID,
                "client_secret": clientSecret,
                "redirect_uri": redirectUri,
                "code": code,
                "grant_type": grantType
            ]
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["Authorization": "Client-ID \(UnsplashApiConfig.ACCESS_KEY)"]
    }
    
    // Define all the API need to call here:
    
    var validationType: ValidationType {
        switch self {
        case .listPhoto, .authorize, .token:
            return .customCodes([200])
        }
        
    }
}


