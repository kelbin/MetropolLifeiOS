//
//  CategoriesCollectionViewCell.swift
//  MetropolLifeiOS
//
//  Created by Kelbinary on 27.03.2021.
//  Copyright © 2021 Kelbinary. All rights reserved.
//


import UIKit

final class CategoriesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleOfCategory: UILabel!
    @IBOutlet weak var bottomLine: UIImageView!
    
    func config(model: MainCategoriesModel) {
        
        titleOfCategory.text = model.text
        
        bottomLine.image = #imageLiteral(resourceName: "bottomLine")
        
        switch model.isSelected {
        case true:
            bottomLine.isHidden = false
        case false:
            bottomLine.isHidden = true
        }
        
    }
}
