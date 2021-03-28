//
//  ChatListViewController.swift
//  MetropolLifeiOS
//
//  Created by Савченко Максим Олегович on 28.03.2021.
//  Copyright © 2021 Kelbinary. All rights reserved.
//

import UIKit

final class ChatListViewController: UIViewController {
    
    @IBOutlet weak var techImageView: UIImageView!
    @IBOutlet weak var techSupportControl: UIControl!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        techImageView.isUserInteractionEnabled = true
        techImageView.addGestureRecognizer(tapGestureRecognizer)
        techSupportControl.addTarget(self, action: #selector(goToChat), for: .touchUpInside)
    }
    
    @objc func goToChat() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let tappedImage = tapGestureRecognizer.view as! UIImageView

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
        navigationController?.pushViewController(controller, animated: true)
    }
    
}
