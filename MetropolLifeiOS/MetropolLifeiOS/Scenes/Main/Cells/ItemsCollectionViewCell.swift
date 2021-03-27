//
//  ItemsCollectionViewCell.swift
//  MetropolLifeiOS
//
//  Created by Kelbinary on 27.03.2021.
//  Copyright © 2021 Kelbinary. All rights reserved.

import UIKit

final class ItemsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleOfItem: UILabel!
    @IBOutlet weak var backImage: UIImageView!
    
    func config(model: MainItemsModel) {
        
        titleOfItem.text = model.title
        backImage.image = model.backImage
        backImage.layer.cornerRadius = 20
    }
    
}
