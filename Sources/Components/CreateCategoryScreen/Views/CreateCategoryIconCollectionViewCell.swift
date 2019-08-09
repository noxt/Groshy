//
//  CreateCategoryIconCollectionViewCell.swift
//  Groshy
//
//  Created by Dmitry Ivanenko on 29/07/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import UIKit


final class CreateCategoryIconCollectionViewCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 4
    }
    

    // MARK: - Public Methods
    
    func configure(with icon: Category.Icon, isSelected: Bool) {
        if isSelected {
            layer.borderColor = Colors.red.cgColor
            layer.borderWidth = 1.5
        } else {
            layer.borderColor = nil
            layer.borderWidth = 0
        }
        
        iconImageView.image = icon.image
    }
    
}
