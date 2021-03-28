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
import Alamofire

final class ChatViewController: MessagesViewController, MessageCellDelegate {
    
    enum Constants {
        static let maximumHeight: CGFloat = 146
        static let placeholder = "Введите сообщение"
    }

    lazy var messageList: [MockMessage] = []
    lazy var audioController = BasicAudioController(messageCollectionView: messagesCollectionView)
    var messages: [MockMessage] = []
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        
        HowdiWebsocketService.shared.delegate = self
        
        convertModel()
        
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    
    func getRequestAPICall(model: @escaping ([ListModel]) -> () )  {

        let todosEndpoint: String = "http://143.198.57.44:8000/chat-room?user_id=1"
        
        AF.request(todosEndpoint, method: .get, encoding: JSONEncoding.default)
            .responseJSON { response in
                debugPrint(response)
                model([ListModel(text: "Прошлые сообщение"), ListModel(text: "Прошлые сообщение"), ListModel(text: "Прошлые сообщение")] )
            }
    }
    
    func convertModel() {
        
        getRequestAPICall { model in
            model.forEach { modler in self.messages.append(MockMessage(text: modler.text, user: MockUser(senderId: "25", displayName: "Анастасия, администратор"), messageId: UUID().uuidString, date: Date())) }
            self.loadFirstMessages(messages: self.messages)
        }
        
    }
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        MockSocket.shared.connect(with: [SampleData.shared.child])
            .onNewMessage { [weak self] message in
                self?.insertMessage(message)
        }
        
        let helpText = MockMessage(text: """
           Я могу рассказать вам информации о:
           1. Оплата
           2. Бронирование
           3. Акции
           4. Вызвать оператора
           """, user: MockUser(senderId: "260", displayName: "Чат-бот"), messageId: UUID().uuidString, date: Date())
        
        insertMessage(helpText)
        
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationItem.title = "Служба поддержки"
        self.navigationController?.navigationBar.layoutIfNeeded()
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
        if !MockSocket.shared.isBotConnected {
            HowdiWebsocketService.shared.disconnect()
        }
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
            if isPreviousMessageSameSender(at: indexPath) {
                cell.displayNameLabel.isHidden = true
            } else {
                cell.displayNameLabel.isHidden = false
            }
            
            cell.configure(with: message, at: indexPath, and: messagesCollectionView)

            return cell
        }

        return super.collectionView(collectionView, cellForItemAt: indexPath)
    }
}


extension ChatViewController: HowdiDelegate {
    
    func getMessageFrom(_ message: String) {
        insertMessage(MockMessage(text: message, user: MockUser(senderId: "25", displayName: "Анастасия, администратор"), messageId: UUID().uuidString, date: Date()))
    }
    
}
