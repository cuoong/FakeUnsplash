//
//  MainTabViewController.swift
//  FakeUnsplash
//
//  Created by Trần Tý on 9/15/19.
//  Copyright © 2019 cuong. All rights reserved.
//

import Foundation
import UIKit

class MainTabViewController: UITabBarController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.settupTabBar()
    }
    
    func settupTabBar(){
        let mainVc: UIViewController = TinderViewController()
        mainVc.tabBarItem.image = imageResize(image: UIImage(named: "gallery")!, sizeChange: CGSize(width: 30, height: 30))
        mainVc.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        
        let favoriteVc: UIViewController = TinderViewController()
        favoriteVc.tabBarItem.image = imageResize(image: UIImage(named: "tinder")!, sizeChange: CGSize(width: 30, height: 30))
        favoriteVc.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        
        let chatVc: UIViewController = ChatViewController()
        chatVc.tabBarItem.image = imageResize(image: UIImage(named: "chat")!, sizeChange: CGSize(width: 30, height: 30))
        chatVc.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        
        viewControllers = [favoriteVc, mainVc, chatVc]
    }
    
    
}
extension MainTabViewController {
    func imageResize (image:UIImage, sizeChange:CGSize)-> UIImage{
        
        let hasAlpha = true
        let scale: CGFloat = 0.0 // Use scale factor of main screen
        
        UIGraphicsBeginImageContextWithOptions(sizeChange, !hasAlpha, scale)
        image.draw(in: CGRect(origin: CGPoint.zero, size: sizeChange))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()!
        return scaledImage
    }

}
