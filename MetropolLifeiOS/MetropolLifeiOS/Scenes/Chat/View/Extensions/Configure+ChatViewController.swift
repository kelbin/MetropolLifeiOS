//
//  Configure+ChatViewController.swift
//  MetropolLifeiOS
//
//  Created by Kelbinary on 27.03.2021.
//  Copyright © 2021 Kelbinary. All rights reserved.
//

import Foundation
import MessageKit
import InputBarAccessoryView

extension ChatViewController {
    
    func configure() {
        configureMessageInputBar()
        configureMessageCollectionView()
        configureSendButton()
        configAppearance()
        configurePaddings()
        configureFlowLayout()
        configureLeftButton()
    }
}

fileprivate extension ChatViewController {

    func configurePaddings() {
        messageInputBar.setRightStackViewWidthConstant(to: 48, animated: false)
        messageInputBar.setLeftStackViewWidthConstant(to: 48, animated: false)
    }
    
    func configureLeftButton() {
        let button = InputBarButtonItem()
            .configure {
                $0.image = #imageLiteral(resourceName: "sckrepka")
                $0.contentMode = .center
                $0.setSize(CGSize(width: 11, height: 36), animated: false)
            }.onTouchUpInside { [weak self] _ in
               
            }
        
        messageInputBar.setStackViewItems([button, InputBarButtonItem.fixedSpace(6)], forStack: .left, animated: false)
    }
    
    func configureMessageCollectionView() {
        messagesCollectionView.register(BaseMessageCell.self)
        messagesCollectionView.register(HeaderReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader)
        
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messageCellDelegate = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self

        scrollsToBottomOnKeyboardBeginsEditing = true
        maintainPositionOnKeyboardFrameChanged = true
        
    }
    
    func configureSendButton() {
        let button = messageInputBar.sendButton
        
        button.image = #imageLiteral(resourceName: "sendMark")
        button.title = nil
        button.backgroundColor = .clear
        button.contentMode = .left
    }

    func configureMessageInputBar() {
        messageInputBar.delegate = self
        messageInputBar.inputTextView.delegate = self

        messageInputBar.maxTextViewHeight = Constants.maximumHeight
        messageInputBar.inputTextView.layer.cornerRadius = 10
        messageInputBar.inputTextView.textContainerInset = UIEdgeInsets(top: 6, left: 12, bottom: 4, right: 18)
        messageInputBar.inputTextView.placeholder = Constants.placeholder
        messageInputBar.inputTextView.font = .systemFont(ofSize: 17, weight: .regular)
        messageInputBar.backgroundColor = .white
        messageInputBar.inputTextView.backgroundColor = .white
        messageInputBar.inputTextView.layer.borderColor = #colorLiteral(red: 0.908448875, green: 0.9187119603, blue: 0.937394917, alpha: 1)
        messageInputBar.inputTextView.layer.borderWidth = 1.0
        messageInputBar.inputTextView.scrollIndicatorInsets = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        messageInputBar.separatorLine.isHidden = true
    }
    
    func configAppearance() {
        messagesCollectionView.backgroundColor = .white
    }
    
    func configureFlowLayout() {
        let flowLayout = messagesCollectionView.messagesCollectionViewFlowLayout
        
        flowLayout.setMessageIncomingAvatarSize(.zero)
        flowLayout.setMessageOutgoingAvatarSize(.zero)
        
        flowLayout.textMessageSizeCalculator.incomingMessageLabelInsets = .init(top: 8, left: 16, bottom: 8, right: 52)
        flowLayout.textMessageSizeCalculator.outgoingMessageLabelInsets = .init(top: 8, left: 16, bottom: 8, right: 52)
    }
}

