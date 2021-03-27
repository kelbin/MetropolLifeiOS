//
//  ChatViewController.swift
//  MetropolLifeiOS
//
//  Created by Kelbinary on 27.03.2021.
//  Copyright © 2021 Kelbinary. All rights reserved.
//

import UIKit
import MessageKit
import InputBarAccessoryView
import SnapKit

final class ChatViewController: MessagesViewController, MessageCellDelegate {
    
    enum Constants {
        static let maximumHeight: CGFloat = 146
        static let placeholder = "Сообщение"
    }

    lazy var messageList: [MockMessage] = []
    lazy var audioController = BasicAudioController(messageCollectionView: messagesCollectionView)
    
    let model: ChatHistoryModel
    let senderName: String
    let stompSocket: StompSocket = StompSocketImp()
    let chatId: Int
    
    init(model: ChatHistoryModel, senderName: String, chatId: Int) {
        self.model = model
        self.senderName = senderName
        self.chatId = chatId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        
//        HowdiWebsocketService.shared.delegate = self
//
//        let url = Core.Network.protocolUrl + Core.Network.baseURL + Core.Network.chatURL + "/websocket"
//
//        HowdiWebsocketService.shared.initializeService(url: url)
        
        loadFirstMessages(messages: convertModel())
        
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    
    private func convertModel() -> [MockMessage] {
        model.messageList.map({ MockMessage(
            text: $0.message ?? "",
            user: $0.senderId == 15 ? SampleData.shared.currentSender : SampleData.shared.child,
            messageId: String($0.messageId),
            date: (dateConvert(from: $0.sendingTime ?? 0)))
            }).reversed()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        MockSocket.shared.connect(with: [SampleData.shared.currentSender, SampleData.shared.child])
//            .onNewMessage { [weak self] message in
//                self?.insertMessage(message)
//        }
        
        self.navigationItem.title = senderName
    }
    
    func dateConvert(from time: Int) -> Date {

        let date = Date(timeIntervalSince1970: TimeInterval(time / 1000))

        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.locale = Locale(identifier: "ru_RU")
        dayTimePeriodFormatter.dateFormat = "HH:mm"
        dayTimePeriodFormatter.timeZone = TimeZone(identifier: "Europe/Moscow")

        return date
    }


    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        MockSocket.shared.disconnect()
        audioController.stopAnyOngoingPlaying()
    }

    public override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let messagesDataSource = messagesCollectionView.messagesDataSource else {
            fatalError("Ouch. nil data source for messages")
        }

        guard !isSectionReservedForTypingIndicator(indexPath.section) else {
            return super.collectionView(collectionView, cellForItemAt: indexPath)
        }

        let message = messagesDataSource.messageForItem(at: indexPath, in: messagesCollectionView)

        if case .text = message.kind {
            let cell = messagesCollectionView.dequeueReusableCell(BaseMessageCell.self, for: indexPath)

            cell.configure(with: message, at: indexPath, and: messagesCollectionView)

            return cell
        }

        return super.collectionView(collectionView, cellForItemAt: indexPath)
    }
}

extension ChatViewController: WebsocketServiceDelegate {
    
    func didGetJson(with message: String) {
        let model = MockMessage(text: message, user: SampleData.shared.child, messageId: UUID().uuidString, date: Date())
        insertMessage(model)
    }
    
}
