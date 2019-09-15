//
//  MainViewModel.swift
//  FakeUnsplash
//
//  Created by Trần Tý on 9/13/19.
//  Copyright © 2019 cuong. All rights reserved.
//

import Foundation
import PromiseKit

@objc class MainViewModel: NSObject {
    var service: UnsplashService
    
    var photos: Array<UnsplashEntities.PhotoEntity> = [] {
        didSet {
            if self.photos.count < 3 {
                self.requestPhotos()
            }
        }
    }
    
    var favoritePhotos: Array<UnsplashEntities.PhotoEntity> = [] {
        didSet {
            self.favoritePhotoCount = self.favoritePhotos.count
        }
    }
    
    @objc dynamic var favoritePhotoCount: Int = 0 
    
    var pageIndex: Int = 1
    
    init(service: UnsplashService) {
        self.service = service
    }

    @discardableResult
    func requestPhotos() -> Promise<Bool>{
        return Promise<Bool>{seal in
            service.listPhoto(page: pageIndex, perPage: 10, orderBy: .latest)
                .done { [unowned self](data) in
                    self.photos.append(contentsOf: data)
                    self.pageIndex += 1
                    seal.fulfill(true)
                }.catch(seal.reject)
        }
        
    }
    
    func popPhoto(_ photo: UnsplashEntities.PhotoEntity){
        let _ = photos.popLast()
    }
}
