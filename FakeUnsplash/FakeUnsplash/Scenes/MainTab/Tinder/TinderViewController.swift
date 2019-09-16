//
//  MainViewController.swift
//  FakeUnsplash
//
//  Created by cuong on 9/11/19.
//  Copyright © 2019 cuong. All rights reserved.
//

import UIKit
import Moya

class TinderViewController: UIViewController {
    
    var viewModel: TinderViewModel!
    
    var tinderCards: [UnsplashTinderPhotoCard] = [UnsplashTinderPhotoCard(), UnsplashTinderPhotoCard()]
    
    var observePhotos: NSKeyValueObservation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let service = UnsplashService(provider: MoyaProvider<UnsplashTargetType>())
        viewModel = TinderViewModel(service: service)
        
        self.requestPhotos()
        self.initView()
        self.bindingViewModel()
    }
    
    func initView() {
        view.backgroundColor = .white
    }
    
    func bindingViewModel(){
        observePhotos = viewModel.observe(\TinderViewModel.favoritePhotoCount, options: [.new]) { [unowned self](_, change) in
            self.tabBarItem.badgeValue = "\(change.newValue ?? 0)"
        }
    }
    
    func requestPhotos(){
        viewModel.requestPhotos()
            .done { (success) in
                self.settupRescusiveCards()
            }.catch { (_) in
                
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
    
        tinderCard.snp.makeConstraints { (make) in
            make.width.equalTo(self.view).inset(30)
            make.center.equalTo(self.view)
            make.top.equalTo(self.view).inset(30)
            make.bottom.equalTo(self.view).inset(50)
            
        }
        self.viewModel.getTopPhotoOnQueueAndPopit()
            .done { (photo) in
                tinderCard.photo = photo
            }.catch { (_) in
                
        }
       
    }

    deinit {
        observePhotos.invalidate()
    }
}

extension TinderViewController: TinderImageCardDelegate {
    
    
    func tinderImageCard(_ card: TinderImageCard, onPanBegin sender: UIPanGestureRecognizer) {
        
    }
    
    func tinderImageCard(_ card: TinderImageCard, onPanMove sender: UIPanGestureRecognizer, direction: Direction) {
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
