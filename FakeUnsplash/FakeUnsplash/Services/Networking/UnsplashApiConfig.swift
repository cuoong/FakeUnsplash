//
//  UnsplashApiConfig.swift
//  FakeUnsplash
//
//  Created by Trần Tý on 9/12/19.
//  Copyright © 2019 cuong. All rights reserved.
//

import Foundation

struct UnsplashApiConfig {
    static let BASE_URL: String = "https://api.unsplash.com/"
    static let AUTHORIZE_BASE_URL: String = "https://unsplash.com/oauth/"
    static let ACCESS_KEY: String = "8f1aa2447dff1a97856810c12e36cbc03d82057397a72cd285fc5fd8aff040b4"
    static let SECRET_KEY : String = "f7550d6a7110bc24caf1abd087e1bf107bba2cdfdb4e04f955bbd2b606ea00fd"
    
    static let shared: UnsplashApiConfig = UnsplashApiConfig()
    
    var accessToken: String = ""
    
}
