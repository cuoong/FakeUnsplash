//
//  ImageCard.swift
//  FakeUnsplash
//
//  Created by Trần Tý on 9/13/19.
//  Copyright © 2019 cuong. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

enum Direction {
    case left, right, bottom, top
}

protocol TinderImageCardDelegate {
    func tinderImageCard(_ card: TinderImageCard, onPanBegin sender: UIPanGestureRecognizer)
    
    func tinderImageCard(_ card: TinderImageCard, onPanMove sender: UIPanGestureRecognizer)
    
    func tinderImageCard(_ card: TinderImageCard, onDragOut direction: Direction)
    
    func tinderImageCard(onReverseDragation card: TinderImageCard)
}

class TinderImageCard: UIView {
    
    var imageView: UIImageView = UIImageView()
    var loadingView: UIActivityIndicatorView = UIActivityIndicatorView()
    
    var delegate: TinderImageCardDelegate?
    
    var panBeginPoint: CGPoint = CGPoint.zero
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initUI()
        self.configureInteraction()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    func initUI() {
        self.layer.cornerRadius = 20.0
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 20.0
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowRadius = 12.0
        self.layer.shadowOpacity = 0.7
        self.backgroundColor = .red
        
        self.addSubview(imageView)
        
        imageView.backgroundColor = .white
        
        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top)
            make.bottom.equalTo(self.snp.bottom)
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
        }
        
        self.addSubview(loadingView)
        loadingView.color = .green
        loadingView.frame.size = CGSize(width: 50, height: 50)
        
        loadingView.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top)
            make.bottom.equalTo(self.snp.bottom)
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
        }
    }
    
    func configureInteraction(){
        let pangesture: UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(onPan))
        self.addGestureRecognizer(pangesture)
    }
    
    @objc func onPan(_ sender: UIPanGestureRecognizer){
        
        switch sender.state {
        case .began:
           onPanBegin(sender)
        case .changed:
           onPanMove(sender)
           break;
        case .ended:
           onPanEnd(sender)
           break;
        default:
            return
        }
    }
    
    func onPanBegin(_ sender: UIPanGestureRecognizer){
        let translatePoint: CGPoint = sender.translation(in: self.superview)
        panBeginPoint = sender.location(in: superview)
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 9, initialSpringVelocity: 0, options: [.curveLinear], animations: {
            self.transform = CGAffineTransform(rotationAngle: translatePoint.x / 20)
        }, completion: nil)
    }
    
    func onPanMove(_ sender: UIPanGestureRecognizer){
        delegate?.tinderImageCard(self, onPanMove: sender)
        let currentPoint: CGPoint = self.center
        let translatePoint: CGPoint = sender.translation(in: self.superview)
        self.center = CGPoint(x: currentPoint.x + translatePoint.x, y: currentPoint.y + translatePoint.y)
        sender.setTranslation(CGPoint.zero, in: self.superview)
    }
    
    func onPanEnd(_ sender: UIPanGestureRecognizer){
        let senderState: (isDragout: Bool, direction: Direction) = getSenderState(sender)
        
        if senderState.isDragout {
            UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [.curveLinear], animations: {
                self.transform = CGAffineTransform(translationX: -220, y: 220).rotated(by: 12)
                self.layer.opacity = 0
               
            }){ bool in
                 self.removeFromSuperview()
            }
            delegate?.tinderImageCard(self, onDragOut: senderState.direction)
            return;
        }
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [.curveEaseInOut], animations: {
            self.transform = .identity
            self.center = self.superview!.center
        }, completion: nil)
        delegate?.tinderImageCard(onReverseDragation: self)
    }
    
    func getSenderState(_ sender: UIPanGestureRecognizer) -> (isDragout: Bool, direction: Direction){
        let endLocationOfSender: CGPoint = sender.location(in: superview)
        let translation: (x: Float, y: Float) = (x: Float(endLocationOfSender.x - panBeginPoint.x), y: Float(endLocationOfSender.y - panBeginPoint.y))
        let isDragout: Bool = abs(translation.x) > 120
        
        return (isDragout, direction: .left)
    }
}
