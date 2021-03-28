//
//  MainViewController.swift
//  MetropolLifeiOS
//
//  Created by Kelbinary on 27.03.2021.
//  Copyright © 2021 Kelbinary. All rights reserved.
//

import UIKit
import AdvancedPageControl
import IntentsUI
import Intents

struct MainCategoriesModel {
    let text: String
    var isSelected: Bool
}

struct MainItemsModel  {
    let backImage: UIImage
    let title: String
}

final class MainViewController: UIViewController {

    @IBOutlet weak var pageControl: AdvancedPageControlView!
    
    @IBOutlet weak var itemsCollectionView: UICollectionView!
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    
    let button = INUIAddVoiceShortcutButton(style: .whiteOutline)
    
    var categoriesArray: [MainCategoriesModel] = [MainCategoriesModel(text: "Номера", isSelected: true),
                                                  MainCategoriesModel(text: "Услуги", isSelected: false),
                                                  MainCategoriesModel(text: "Кухня", isSelected: false),
                                                  MainCategoriesModel(text: "Свадьба", isSelected: false),
                                                  MainCategoriesModel(text: "Залы", isSelected: false),
                                                     MainCategoriesModel(text: "Предложения", isSelected: false)]
    
    var itemsArray: [MainItemsModel] = [MainItemsModel(backImage: #imageLiteral(resourceName: "backImage"), title: "Люкс Делюкс"),
                                        MainItemsModel(backImage: #imageLiteral(resourceName: "backImage"), title: "Представительский номер"),
                                        MainItemsModel(backImage: #imageLiteral(resourceName: "backImage"), title: "Гранд Супериор")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        pageControl.drawer = ExtendedDotDrawer(numberOfPages: itemsArray.count, height: 6, width: 6, space: 6, raduis: 20, indicatorColor: #colorLiteral(red: 0.8549019608, green: 0.8549019608, blue: 0.8549019608, alpha: 1), dotsColor: #colorLiteral(red: 0.8549019608, green: 0.8549019608, blue: 0.8549019608, alpha: 1))
        pageControl.numberOfPages = itemsArray.count
        addSiriButton(to: self.view)
        
        self.becomeFirstResponder()
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
    
    func addSiriButton(to view: UIView) {
    if #available(iOS 12.0, *) {
            button.isHidden = true
            button.shortcut = INShortcut(intent: intent)
            button.delegate = self
            button.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(button)
            view.centerXAnchor.constraint(equalTo: button.centerXAnchor).isActive = true
            view.centerYAnchor.constraint(equalTo: button.centerYAnchor).isActive = true
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

}

extension MainViewController {
    
    @available(iOS 12.0, *)
    public var intent: OrderReceptionIntent {
        let testIntent = OrderReceptionIntent()
        testIntent.suggestedInvocationPhrase = "Заказать ресепшен"
        return testIntent
    }
    
}

extension MainViewController: INUIAddVoiceShortcutButtonDelegate {
    
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

extension MainViewController: INUIAddVoiceShortcutViewControllerDelegate {
    @available(iOS 12.0, *)
    func addVoiceShortcutViewController(_ controller: INUIAddVoiceShortcutViewController, didFinishWith voiceShortcut: INVoiceShortcut?, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    @available(iOS 12.0, *)
    func addVoiceShortcutViewControllerDidCancel(_ controller: INUIAddVoiceShortcutViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
}

extension MainViewController: INUIEditVoiceShortcutViewControllerDelegate {
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

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case itemsCollectionView:
            return itemsArray.count
        case categoriesCollectionView:
            return categoriesArray.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        case itemsCollectionView:
            let itemsModel = itemsArray[indexPath.row]
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemsCollectionViewCell", for: indexPath) as? ItemsCollectionViewCell else { fatalError() }
            cell.config(model: itemsModel)
            return cell
        case categoriesCollectionView:
            let categoriesModel = categoriesArray[indexPath.row]
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCollectionViewCell", for: indexPath) as? CategoriesCollectionViewCell else { fatalError() }
            cell.config(model: categoriesModel)
            return cell
        default:
            return UICollectionViewCell()
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch collectionView {
        case itemsCollectionView:
            
            print("")
        case categoriesCollectionView:
            
            categoriesArray.enumerated().forEach { (offset, model) in
                if offset != indexPath.row {
                    categoriesArray[offset].isSelected = false
                } else {
                    categoriesArray[offset].isSelected = true
                }
            }
            
            collectionView.reloadData()
            
            print("")
        default:
            break
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case itemsCollectionView:
            return CGSize(width: 308, height: itemsCollectionView.bounds.size.height)
        default:
            return CGSize(width: 60, height: 40)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 14
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.x
        let width = scrollView.frame.width
        
        pageControl.setPage(Int(round(offset/width)))
    }
    
}
