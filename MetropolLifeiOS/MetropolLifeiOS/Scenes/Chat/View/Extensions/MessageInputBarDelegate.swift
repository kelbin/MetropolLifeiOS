//
//  MessageInputBarDelegate.swift
//  MetropolLifeiOS
//
//  Created by Kelbinary on 27.03.2021.
//  Copyright © 2021 Kelbinary. All rights reserved.
//

import Foundation
import InputBarAccessoryView
import MessageKit

// MARK: - MessageInputBarDelegate

extension ChatViewController: InputBarAccessoryViewDelegate {
    
    func didPick(_ image: UIImage, indexPath: IndexPath?) {
        insertMessages([image])
        messagesCollectionView.scrollToBottom(animated: true)
    }
    
    @objc func didTapRecord() {
        let url = Bundle.main.url(forResource: "sound1", withExtension: "m4a")!
        let user = SampleData.shared.currentSender
        insertMessage(MockMessage(audioURL: url, user: user, messageId: UUID().uuidString, date: Date()))
        messagesCollectionView.scrollToBottom(animated: true)
    }

    @objc public func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        processInputBar(inputBar)
        messagesCollectionView.scrollToBottom(animated: true)
    }
}


#warning("mock")
extension ChatViewController {
    
    func processInputBar(_ inputBar: InputBarAccessoryView) {
        // Here we can parse for which substrings were autocompleted
        let attributedText = inputBar.inputTextView.attributedText!
        let range = NSRange(location: 0, length: attributedText.length)
        attributedText.enumerateAttribute(.autocompleted, in: range, options: []) { (_, range, _) in

            let substring = attributedText.attributedSubstring(from: range)
            let context = substring.attribute(.autocompletedContext, at: 0, effectiveRange: nil)
            print("Autocompleted: `", substring, "` with context: ", context ?? [])
        }

        let components = inputBar.inputTextView.components
        inputBar.inputTextView.text = String()
        inputBar.invalidatePlugins()
        // Send button activity animation
        inputBar.sendButton.startAnimating()
        inputBar.inputTextView.placeholder = "Отправка..."
        // Resign first responder for iPad split view
        inputBar.inputTextView.resignFirstResponder()
        DispatchQueue.global(qos: .default).async {
            // fake send request task
            sleep(1)
            DispatchQueue.main.async { [weak self] in
                inputBar.sendButton.stopAnimating()
                inputBar.inputTextView.placeholder = ChatViewController.Constants.placeholder
                self?.insertMessages(components)
                
                if MockSocket.shared.isBotConnected == true {
                    for component in components {
                    let user = SampleData.shared.currentSender
                        if let str = component as? String {
                            let message = MockMessage(text: str, user: user, messageId: UUID().uuidString, date: Date())
                            let answer = MockSocket.shared.getAnswerFromBot(mock: message)
                            
                            switch answer.kind {
                            case .text(let string):
                                
                                if string == "Вызываю оператора..." {
                                    MockSocket.shared.isBotConnected = false
                                    HowdiWebsocketService.shared.connect()
                                }
                                
                            default:
                                break
                            }
    
                            self?.insertMessage(answer)
                        }
                    }
                } else {
                    
                    for component in components {
                    let user = SampleData.shared.currentSender
                        if let str = component as? String {
                            HowdiWebsocketService.shared.sendMessage(str)
                        }
                    }
                    
                }
                
                self?.messagesCollectionView.scrollToBottom(animated: true)
            }
        }
    }
}
