//
//  UnsplashServicesTest.swift
//  FakeUnsplashTests
//
//  Created by Trần Tý on 9/12/19.
//  Copyright © 2019 cuong. All rights reserved.
//

import XCTest

@testable import Moya
@testable import PromiseKit

class UnsplashServicesTests: XCTestCase {
    var service: UnsplashService?
    var provider: MoyaProvider<UnsplashTargetType>?
    override func setUp() {
        provider = MoyaProvider<UnsplashTargetType>(stubClosure: MoyaProvider<UnsplashTargetType>.immediatelyStub)
        service = UnsplashService(provider: provider!)
        
    }
    
    func testListPhoto(){
        provider?.request(.listPhoto(page: 1, perPage: 1, orderBy: .latest), completion: { (result) in
            XCTAssertNotEqual(try? result.value?.mapString(), "")
        })
        provider?.request(.listPhoto(page: -1, perPage: 1, orderBy: .latest), completion: { (result) in
            XCTAssertEqual(try? result.value?.mapString(), "")
        })
    }
}
