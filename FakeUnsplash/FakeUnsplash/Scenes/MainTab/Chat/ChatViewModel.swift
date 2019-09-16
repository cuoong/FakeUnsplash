//
//  ChatViewModel.swift
//  FakeUnsplash
//
//  Created by Trần Tý on 9/16/19.
//  Copyright © 2019 cuong. All rights reserved.
//

import Foundation
import TwilioChatClient

@objc class ChatViewModel: NSObject {
    static var token: String = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiIsImN0eSI6InR3aWxpby1mcGE7dj0xIn0.eyJqdGkiOiJTS2NkZWM3NDQ4MGI5OTljYjgyNDBlODc5OTdjNTg2MTQyLTE1Njg2MjcyNzMiLCJpc3MiOiJTS2NkZWM3NDQ4MGI5OTljYjgyNDBlODc5OTdjNTg2MTQyIiwic3ViIjoiQUM4MmM0MjNkY2Y5MzE1NDZmYmM3YjViMTRjMWJmMWQ5OCIsImV4cCI6MTU2ODcxMzY3MywiZ3JhbnRzIjp7ImlkZW50aXR5Ijo1NCwiY2hhdCI6eyJzZXJ2aWNlX3NpZCI6IklTN2QwOWIwYmQ1MTU3NGI4ODg0NTRjYWI0ZWUxMjZjOWMiLCJwdXNoX2NyZWRlbnRpYWxfc2lkIjoiQ1I4NDJiNzhiYmY2NzYzN2ZhM2JkOTExMjE5MzU1NGYxMCJ9LCJ2aWRlbyI6e319fQ.FXQEdMh68WkZktzzaMo5weS_Nz0DKgKmR85hQBtNV1Y"
    var client: TwilioChatClient?
    
    @objc dynamic var channels: Array<TCHChannel> = []
    
    override init() {
        super.init()
        TwilioChatClient.chatClient(withToken: ChatViewModel.token, properties: nil, delegate: self) { [unowned self](_, client) in
            self.client = client
            self.getSubcribedChannels()
        }
    }

    func getSubcribedChannels(){
        if let client = self.client, let channelList = client.channelsList() {
           channels = channelList.subscribedChannels()
        }
    }
}

extension ChatViewModel: TwilioChatClientDelegate {
    func chatClient(_ client: TwilioChatClient, connectionStateUpdated state: TCHClientConnectionState) {
    
    }
    
    ch
}


