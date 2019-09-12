//
//  MainViewController.swift
//  FakeUnsplash
//
//  Created by cuong on 9/11/19.
//  Copyright © 2019 cuong. All rights reserved.
//

import UIKit
import Moya

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let service = UnsplashService(provider: MoyaProvider<UnsplashTargetType>())
//        service.authorize(clientID: UnsplashApiConfig.ACCESS_KEY, redirectUri: "http://localhost.com", responseType: "code", scope: "public+read_user")
//            .done { (success) in
//                print(success)
//        }
//            .catch { (er) in
//                print(er)
//        }
        service.listPhoto(page: 1, perPage: 10, orderBy: .latest)
            .done { (data) in
                print(data)
            }.catch { (er) in
                print(er)
        }
        
    }

}

