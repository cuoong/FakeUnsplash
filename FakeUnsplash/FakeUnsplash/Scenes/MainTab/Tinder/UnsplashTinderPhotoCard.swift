//
//  UnsplashTinderPhotoCard.swift
//  FakeUnsplash
//
//  Created by Trần Tý on 9/13/19.
//  Copyright © 2019 cuong. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class UnsplashTinderPhotoCard: TinderImageCard {
    
    var photo: UnsplashEntities.PhotoEntity! {
        didSet {
            self.configure()
        }
    }
    
    convenience init(frame: CGRect = CGRect.zero, photo: UnsplashEntities.PhotoEntity) {
        self.init(frame: frame)
        self.photo = photo
    }
    
    func configure(){
        let imageUrl: URL = URL(string: photo.urls.regular)!
        self.loadingView.startAnimating()
        imageView.kf.setImage(with: imageUrl, placeholder: nil, options: [
            .scaleFactor(UIScreen.main.scale),
            .transition(.fade(1)),
            .cacheOriginalImage
        ], progressBlock: nil) { (_, _, _, _) in
            self.loadingView.stopAnimating()
        }
        
        
    }
}
