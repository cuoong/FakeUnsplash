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
    
    var viewModel: MainViewModel!
    
    var tinderCards: [UnsplashTinderPhotoCard] = [UnsplashTinderPhotoCard(), UnsplashTinderPhotoCard()]
    
    var observePhotos: NSKeyValueObservation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let service = UnsplashService(provider: MoyaProvider<UnsplashTargetType>())
        viewModel = MainViewModel(service: service)
        viewModel.requestPhotos()
            .done { (success) in
                self.settupRescusiveCards()
            }.catch { (_) in
                
        }
        self.initView()
        self.bindingViewModel()
    }
    
    func initView() {
        view.backgroundColor = .white
    }
    
    func bindingViewModel(){
        observePhotos = viewModel.observe(\MainViewModel.favoritePhotoCount, options: [.new]) { [unowned self](_, change) in
            self.tabBarItem.badgeValue = "\(change.newValue ?? 0)"
        }
    }
    
    func settupRescusiveCards() {
        
        
        for (index, tinderCard) in tinderCards.enumerated() {
            configureCard(tinderCard, index: index)
            if index < tinderCards.count - 1 {
                tinderCard.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            }
        }
        
    }
    
    
    func configureCard(_ tinderCard: UnsplashTinderPhotoCard, index: Int){
        self.view.insertSubview(tinderCard, at: index)
        tinderCard.delegate = self
        let size: CGSize = self.view.frame.size
        tinderCard.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: size.width - 30, height: size.height * 0.6))
            make.center.equalTo(self.view.center)
        }
        tinderCard.photo = self.viewModel.photos.popLast()
       
    }
    
    deinit {
//        observePhotos.removeObserver(self.viewModel, forKeyPath: \MainViewModel.photoCount)
    }

}

extension MainViewController: TinderImageCardDelegate {
    func tinderImageCard(_ card: TinderImageCard, onPanBegin sender: UIPanGestureRecognizer) {
        
    }
    
    func tinderImageCard(_ card: TinderImageCard, onPanMove sender: UIPanGestureRecognizer) {
        
        guard let index: Int = tinderCards.firstIndex(of: card as! UnsplashTinderPhotoCard) else{
            return
        }
        let cardBehind: UnsplashTinderPhotoCard = tinderCards[index - 1]
        UIView.animate(withDuration: 0.3, animations: {
            cardBehind.transform = .identity
        }, completion: nil)
       
    }
    
    func tinderImageCard(_ card: TinderImageCard, onDragOut direction: Direction) {
        
        let unsplashCard = card as! UnsplashTinderPhotoCard
        
        let _ = tinderCards.popLast()
        let newCard: UnsplashTinderPhotoCard = UnsplashTinderPhotoCard()
        configureCard(newCard, index: 0)
        tinderCards.insert(newCard, at: 0)
        newCard.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        
        if direction == .left {
            viewModel.favoritePhotos.append(unsplashCard.photo)
        }
        
    }
    
    func tinderImageCard(onReverseDragation card: TinderImageCard) {
        guard let index: Int = tinderCards.firstIndex(of: card as! UnsplashTinderPhotoCard) else{
            return
        }
        let cardBehind: UnsplashTinderPhotoCard = tinderCards[index - 1]
        UIView.animate(withDuration: 0.3, animations: {
            cardBehind.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }, completion: nil)
    }
    
    
}
