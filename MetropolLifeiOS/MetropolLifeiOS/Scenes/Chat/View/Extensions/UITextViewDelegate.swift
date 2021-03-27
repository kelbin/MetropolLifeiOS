//
//  UITextViewDelegate.swift
//  MetropolLifeiOS
//
//  Created by Kelbinary on 27.03.2021.
//  Copyright © 2021 Kelbinary. All rights reserved.
//

import Foundation
import UIKit

extension ChatViewController: UITextViewDelegate {
    
    public override func becomeFirstResponder() -> Bool {
        super.becomeFirstResponder()
        
        messageInputBar.inputTextView.placeholder = Constants.placeholder
        
        return true
    }
    
    public override func resignFirstResponder() -> Bool {
        super.resignFirstResponder()
        
        messageInputBar.inputTextView.placeholder = nil
        
        return true
    }
}
