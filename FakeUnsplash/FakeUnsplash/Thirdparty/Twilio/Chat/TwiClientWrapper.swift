//
//  TwiClientWrapper.swift
//  FakeUnsplash
//
//  Created by Trần Tý on 9/16/19.
//  Copyright © 2019 cuong. All rights reserved.
//

import Foundation
import TwilioChatClient

class TwiChatClientWrapper: NSObject {
    var client: TwilioChatClient
    
    init(client: TwilioChatClient) {
        self.client = client;
        super.init()
        client.delegate = self
    }
    
//    func getChannel
}

extension TwiChatClientWrapper: TwilioChatClientDelegate {
    func chatClientTokenExpired(_ client: TwilioChatClient) {
        
    }
}
