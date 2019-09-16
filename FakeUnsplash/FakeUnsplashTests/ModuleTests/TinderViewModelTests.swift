//
//  TinderViewModelTests.swift
//  FakeUnsplashTests
//
//  Created by Trần Tý on 9/16/19.
//  Copyright © 2019 cuong. All rights reserved.
//

import Foundation
import XCTest
@testable import Moya

class TinderViewModelTests: XCTestCase {
    var vm: TinderViewModel {
        let service: UnsplashService = UnsplashService(provider: MoyaProvider<UnsplashTargetType>())
        return TinderViewModel(service: service)
    }
    
    func testPhoto(){
        let expectation: XCTestExpectation = XCTestExpectation(description: "");
        vm.getTopPhotoOnQueueAndPopit()
            .done { (photo) in
                XCTAssertNotNil(photo)
                expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
        
    }
}
