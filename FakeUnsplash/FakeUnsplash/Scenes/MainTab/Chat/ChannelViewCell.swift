//
//  ChannelViewCell.swift
//  FakeUnsplash
//
//  Created by Trần Tý on 9/16/19.
//  Copyright © 2019 cuong. All rights reserved.
//

import Foundation
import UIKit
import TwilioChatClient

class ChannelViewCell: UICollectionViewCell {
    
    var viewModel: ChannelViewCellViewModel?
    
    var lastMessageView: UILabel = UILabel()
    
    var observationMessages: NSKeyValueObservation?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        settupView()
    }
    
    func settupView(){
        contentView.addSubview(lastMessageView)
        self.backgroundColor = .white
        lastMessageView.snp.makeConstraints { (m) in
            m.size.equalTo(CGSize(width: 200, height: 50))
            
        }
    }
    
    func configure(channel: TCHChannel) {
        viewModel = ChannelViewCellViewModel(channel: channel)
        self.bindding()
    }
    
    func bindding(){
        if let vm = self.viewModel {
            observationMessages = vm.observe(\ChannelViewCellViewModel.messages, options: [.new], changeHandler: { (_, change) in
                if let newValue = change.newValue {
                    self.lastMessageView.text = "test"
                }
            })
        }
    }
}
