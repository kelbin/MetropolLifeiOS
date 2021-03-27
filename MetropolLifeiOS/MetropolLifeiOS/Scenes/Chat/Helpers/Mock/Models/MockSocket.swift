//
//  MockSocket.swift
//  MetropolLifeiOS
//
//  Created by Kelbinary on 27.03.2021.
//  Copyright © 2021 Kelbinary. All rights reserved.
//

import Foundation

final class MockSocket {
    
    static var shared = MockSocket()
    
    private var timer: Timer?
    
    var isBotConnected: Bool = true
    
    private var queuedMessage: MockMessage?
    
    private var onNewMessageCode: ((MockMessage) -> Void)?
    
    private var onTypingStatusCode: (() -> Void)?
    
    private var connectedUsers: [MockUser] = []
    
    private init() {}
    
    @discardableResult
    func connect(with senders: [MockUser]) -> Self {
        disconnect()
        connectedUsers = senders
//        timer = Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(handleTimer), userInfo: nil, repeats: true)
        return self
    }
    
    @discardableResult
    func disconnect() -> Self {
        timer?.invalidate()
        timer = nil
        onTypingStatusCode = nil
        onNewMessageCode = nil
        return self
    }
    
    @discardableResult
    func onNewMessage(code: @escaping (MockMessage) -> Void) -> Self {
        onNewMessageCode = code
        return self
    }
   
    func getAnswerFromBot(mock: MockMessage) -> MockMessage {
        guard let message = SampleData.shared.getAnswer(mockMessage: mock) else {
            return MockMessage(text: "Неизвестная команда. Повторите еще раз", user: SampleData.shared.child, messageId: UUID().uuidString, date: Date())
        }
        queuedMessage = message
        return message
    }
    
    @discardableResult
    func onTypingStatus(code: @escaping () -> Void) -> Self {
        onTypingStatusCode = code
        return self
    }
    
    @objc
    private func handleTimer() {
        if let message = queuedMessage {
            onNewMessageCode?(message)
            queuedMessage = nil
        } else {
            let sender = connectedUsers.random()!
            let message = SampleData.shared.randomMessage(allowedSenders: [sender])
            queuedMessage = message
            onTypingStatusCode?()
        }
    }
}
