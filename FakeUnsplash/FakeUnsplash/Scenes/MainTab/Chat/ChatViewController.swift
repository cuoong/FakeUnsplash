//
//  ChatViewController.swift
//  FakeUnsplash
//
//  Created by Trần Tý on 9/16/19.
//  Copyright © 2019 cuong. All rights reserved.
//

import Foundation
import UIKit

class ChatViewController: UIViewController {
    
    var viewModel: ChatViewModel!
    var channelListView: ChannelListCollectionView = ChannelListCollectionView()
    
    var observationChannels: NSKeyValueObservation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initView()
        viewModel = ChatViewModel()
        self.binding()
    }
    
    func initView() {
        view.backgroundColor = .white
        
        view.addSubview(channelListView)
        channelListView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }
    
    func binding(){
        observationChannels  = viewModel.observe(\ChatViewModel.channels, options: [.new]) { [unowned self](_, change) in
                self.channelListView.dataSource = self.viewModel.channels
        }
    }
}
