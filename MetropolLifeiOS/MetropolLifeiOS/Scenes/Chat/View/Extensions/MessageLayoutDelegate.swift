//
//  MessageLayoutDelegate.swift
//  MetropolLifeiOS
//
//  Created by Kelbinary on 27.03.2021.
//  Copyright © 2021 Kelbinary. All rights reserved.
//

import Foundation
import MessageKit

// MARK: - MessagesLayoutDelegate

extension ChatViewController: MessagesLayoutDelegate {
    
    public func headerViewSize(for section: Int, in messagesCollectionView: MessagesCollectionView) -> CGSize {
        if !isPreviousMessageHaveHeader(at: IndexPath(item: 0, section: section)) {
            return CGSize(width: messagesCollectionView.bounds.width, height: HeaderReusableView.height)
        }
        return .zero
    }
    
    
    func messageTopLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return 10
    }
    
    public func messageHeaderView(for indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageReusableView {
        let header = messagesCollectionView.dequeueReusableHeaderView(HeaderReusableView.self, for: indexPath)
        if !isPreviousMessageHaveHeader(at: indexPath) {
            let message = messageForItem(at: indexPath, in: messagesCollectionView)
            header.setup(with: message.sentDate)
        }
        return header
    }
}
