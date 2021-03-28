//
//  PlacesViewController.swift
//  MetropolLifeiOS
//
//  Created by Савченко Максим Олегович on 28.03.2021.
//  Copyright © 2021 Kelbinary. All rights reserved.
//

import UIKit
import IntentsUI
import Intents

final class PlacesViewController: UIViewController  {

    let button = INUIAddVoiceShortcutButton(style: .whiteOutline)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSiriButton(to: self.view)
        self.becomeFirstResponder()
        // Do any additional setup after loading the view.
    }
    
    func addSiriButton(to view: UIView) {
       if #available(iOS 12.0, *) {
           button.isHidden = true
           button.shortcut = INShortcut(intent: intent)
           button.delegate = self
           button.translatesAutoresizingMaskIntoConstraints = false
           view.addSubview(button)
          view.bringSubviewToFront(button)
           view.centerXAnchor.constraint(equalTo: button.centerXAnchor).isActive = true
           view.centerYAnchor.constraint(equalTo: button.centerYAnchor).isActive = true
        }
       
    }
    
    override var canBecomeFirstResponder: Bool {
        get {
            return true
        }
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            button.isHidden = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func showMessage() {
        let alert = UIAlertController(title: "Заявка принята", message: "Ожидайте в течении некоторого времени", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Продолжить", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension PlacesViewController {
    
    @available(iOS 12.0, *)
    public var intent: OrderReceptionIntent {
        let testIntent = OrderReceptionIntent()
        testIntent.suggestedInvocationPhrase = "Заказать ресепшен"
        return testIntent
    }
    
}

extension PlacesViewController: INUIAddVoiceShortcutButtonDelegate {
    
    @available(iOS 12.0, *)
    func present(_ addVoiceShortcutViewController: INUIAddVoiceShortcutViewController, for addVoiceShortcutButton: INUIAddVoiceShortcutButton) {
        addVoiceShortcutViewController.delegate = self
        addVoiceShortcutViewController.modalPresentationStyle = .formSheet
        present(addVoiceShortcutViewController, animated: true, completion: nil)
    }
    
    @available(iOS 12.0, *)
    func present(_ editVoiceShortcutViewController: INUIEditVoiceShortcutViewController, for addVoiceShortcutButton: INUIAddVoiceShortcutButton) {
        editVoiceShortcutViewController.delegate = self
        editVoiceShortcutViewController.modalPresentationStyle = .formSheet
        present(editVoiceShortcutViewController, animated: true, completion: nil)
    }
    
}

extension PlacesViewController: INUIAddVoiceShortcutViewControllerDelegate {
    @available(iOS 12.0, *)
    func addVoiceShortcutViewController(_ controller: INUIAddVoiceShortcutViewController, didFinishWith voiceShortcut: INVoiceShortcut?, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    @available(iOS 12.0, *)
    func addVoiceShortcutViewControllerDidCancel(_ controller: INUIAddVoiceShortcutViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
}

extension PlacesViewController: INUIEditVoiceShortcutViewControllerDelegate {
    @available(iOS 12.0, *)
    func editVoiceShortcutViewController(_ controller: INUIEditVoiceShortcutViewController, didUpdate voiceShortcut: INVoiceShortcut?, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    @available(iOS 12.0, *)
    func editVoiceShortcutViewController(_ controller: INUIEditVoiceShortcutViewController, didDeleteVoiceShortcutWithIdentifier deletedVoiceShortcutIdentifier: UUID) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    @available(iOS 12.0, *)
    func editVoiceShortcutViewControllerDidCancel(_ controller: INUIEditVoiceShortcutViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}
