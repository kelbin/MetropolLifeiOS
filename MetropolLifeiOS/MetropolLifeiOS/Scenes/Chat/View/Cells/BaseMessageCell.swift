//
//  BaseMessageCell.swift
//  MetropolLifeiOS
//
//  Created by Kelbinary on 27.03.2021.
//  Copyright © 2021 Kelbinary. All rights reserved.
//

import Foundation
import UIKit
import MessageKit
import SnapKit

open class BaseMessageCell: TextMessageCell {
    
    let timeLabel = UILabel()
    let displayNameLabel = UILabel()
    
    open override func setupSubviews() {
        super.setupSubviews()
        
        messageContainerView.addSubview(messageLabel)
        messageContainerView.addSubview(timeLabel)
        self.contentView.addSubview(displayNameLabel)
        
        timeLabel.snp.makeConstraints { maker in
            maker.right.equalTo(messageLabel.snp.right).offset(-10)
            maker.bottom.equalTo(messageLabel.snp.bottom).offset(-8)
        }
        
        displayNameLabel.snp.makeConstraints { (maker) in
            maker.top.equalTo(self.contentView.snp.top).offset(-10)
            maker.leading.equalTo(self.contentView.snp.leading).offset(0)
        }
        
        messageContainerView.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)
        timeLabel.textAlignment = .right
        timeLabel.textColor = #colorLiteral(red: 0.4589764476, green: 0.499605, blue: 0.5408624411, alpha: 1)
//        timeLabel.font = .mtsSans(style: .regular, size: 14)
        timeLabel.font = .systemFont(ofSize: 14, weight: .regular)
        messageLabel.textColor = .black
        displayNameLabel.textColor = #colorLiteral(red: 0.7997560501, green: 0.6985368133, blue: 0.4625546932, alpha: 1)
//        messageLabel.font = .mtsSans(style: .regular, size: 17)
        messageLabel.font = .systemFont(ofSize: 17, weight: .regular)
        displayNameLabel.font = .systemFont(ofSize: 14, weight: .regular)
    }
    
    open override func configure(with message: MessageType, at indexPath: IndexPath, and messagesCollectionView: MessagesCollectionView) {
        super.configure(with: message, at: indexPath, and: messagesCollectionView)

        guard let displayDelegate = messagesCollectionView.messagesDisplayDelegate else {
            fatalError("MessageKitError.nilMessagesDisplayDelegate")
        }
        
        let enabledDetectors = displayDelegate.enabledDetectors(for: message, at: indexPath, in: messagesCollectionView)

        messageLabel.configure {
            messageLabel.enabledDetectors = enabledDetectors
            for detector in enabledDetectors {
                let attributes = displayDelegate.detectorAttributes(for: detector, and: message, at: indexPath)
                messageLabel.setAttributes(attributes, detector: detector)
            }
            switch message.kind {
            case .text(let text), .emoji(let text):
                let textColor = displayDelegate.textColor(for: message, at: indexPath, in: messagesCollectionView)
                messageLabel.text = text
                messageLabel.textColor = textColor
//                timeLabel.text = message.sentDate.string(dateFormat: .time)
                timeLabel.text = message.sentDate.getFormattedDate(format: "HH:mm")
                displayNameLabel.text = message.sender.displayName
            case .attributedText(let text):
                messageLabel.attributedText = text
            default:
                break
            }
        }
    }
}
