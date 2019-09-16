//
//  ChannelListCollectionView.swift
//  FakeUnsplash
//
//  Created by Trần Tý on 9/16/19.
//  Copyright © 2019 cuong. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import TwilioChatClient

class ChannelListCollectionView: UIView{
    
    var collectionView: UICollectionView!
    
    var dataSource: Array<TCHChannel> = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        settupView()
    }
    
    func settupView(){
        
        let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(ChannelViewCell.self, forCellWithReuseIdentifier: "ChannelViewCell")
        
        collectionView.dataSource = self
        collectionView.delegate = self
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.scrollDirection = .vertical  

        self.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
           make.edges.equalTo(self)
        }
    }
}
extension ChannelListCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ChannelViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChannelViewCell", for: indexPath) as! ChannelViewCell
        cell.configure(channel: dataSource[indexPath.item])
        return cell
    }
    
    
}

extension ChannelListCollectionView: UICollectionViewDelegate {
    
}

extension ChannelListCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width - 20, height: 50)
    }
}
