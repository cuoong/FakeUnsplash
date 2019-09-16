//
//  ChannelViewCellViewModel.swift
//  FakeUnsplash
//
//  Created by Trần Tý on 9/16/19.
//  Copyright © 2019 cuong. All rights reserved.
//

import Foundation
import TwilioChatClient

@objc class ChannelViewCellViewModel: NSObject {
    var channel: TCHChannel {
        didSet {
            channel.delegate = self
        }
    }
    
    @objc dynamic var messages: Array<TCHMessage> = []
    
    init(channel: TCHChannel) {
        self.channel = channel
        super.init()
        getMessages()
    }
    
    func getMessages() {
        if let messages = channel.messages {
            messages.getBefore(20, withCount: 10) { (_, list) in
                if let list = list {
                    self.messages = list
                }
            }
        }
    }
}

extension ChannelViewCellViewModel: TCHChannelDelegate {
    
}
