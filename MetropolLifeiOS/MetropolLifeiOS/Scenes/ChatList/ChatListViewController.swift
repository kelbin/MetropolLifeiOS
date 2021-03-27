//
//  ChatListViewController.swift
//  MetropolLifeiOS
//
//  Created by Савченко Максим Олегович on 28.03.2021.
//  Copyright © 2021 Kelbinary. All rights reserved.
//

import UIKit

final class ChatListViewController: UIViewController {
    
    @IBOutlet weak var techSupport: UIControl!
    @IBOutlet weak var techSupportButton: UIControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        techSupport.addTarget(self, action: #selector(goToChat), for: .touchUpInside)
        techSupportButton.addTarget(self, action: #selector(goToChat), for: .touchUpInside)
    }
    
    @objc func goToChat() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
        navigationController?.pushViewController(controller, animated: true)
    }
    
}
