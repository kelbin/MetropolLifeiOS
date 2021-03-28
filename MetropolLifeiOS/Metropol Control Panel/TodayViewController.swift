//
//  TodayViewController.swift
//  Metropol Control Panel
//
//  Created by Савченко Максим Олегович on 28.03.2021.
//  Copyright © 2021 Kelbinary. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
        
    @IBOutlet weak var clearView: UIControl!
    @IBOutlet weak var edaView: UIControl!
    @IBOutlet weak var serviceView: UIControl!
    
    @IBOutlet weak var clearImageView: UIImageView!
    @IBOutlet weak var edaImageView: UIImageView!
    @IBOutlet weak var serviceImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        clearView.layer.cornerRadius = clearView.bounds.height / 2
        edaView.layer.cornerRadius = clearView.bounds.height / 2
        serviceView.layer.cornerRadius = clearView.bounds.height / 2
        
        let image = clearImageView.image?.withRenderingMode(.alwaysTemplate)
        let image1 = edaImageView.image?.withRenderingMode(.alwaysTemplate)
        let image2 = serviceImageView.image?.withRenderingMode(.alwaysTemplate)
        
        clearImageView.image = image
        edaImageView.image = image1
        serviceImageView.image = image2
        
        clearView.addTarget(self, action: #selector(goToApp), for: .touchUpInside)
        edaView.addTarget(self, action: #selector(goToApp), for: .touchUpInside)
        serviceView.addTarget(self, action: #selector(goToApp), for: .touchUpInside)
        
        // Do any additional setup after loading the view.
        
    }
    
    @objc func goToApp() {
        let url = URL(string: "metropol://")!
        self.extensionContext?.open(url, completionHandler: { (success) in
            if (!success) {
                print("error: failed to open app from Today Extension")
            }
        })
    }
        
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
}
