//
//  MessageDataSource+Chat.swift
//  MetropolLifeiOS
//
//  Created by Kelbinary on 27.03.2021.
//  Copyright © 2021 Kelbinary. All rights reserved.
//

import Foundation
import MessageKit

extension ChatViewController: MessagesDataSource {
    
    public func currentSender() -> SenderType {
        return SampleData.shared.currentSender
    }

    public func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messageList.count
    }

    public func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messageList[indexPath.section]
    }
    
    public func messageStyle(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageStyle {
        
        let backgroundColor = isFromCurrentSender(message: message) ? #colorLiteral(red: 0.7997560501, green: 0.6985368133, blue: 0.4625546932, alpha: 1) : #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)

        let custom = MessageStyle.custom { view in
            view.backgroundColor = backgroundColor
            view.layer.cornerRadius = 16.0
        }
        
        return custom
    }
}
