//
//  Created by Dmitry Ivanenko on 01/08/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import UIKit


final class AddCategoryCell: UICollectionViewCell {
    
    // MARK: - Types
    
    private struct Constants {
        static let cornerRadius: CGFloat = 4
    }
    
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    
    // MARK: - Lifetime
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = Constants.cornerRadius
        
        titleLabel.text = "Добавить"
        titleLabel.font = Fonts.Rubik.Regular(size: 12)
        titleLabel.textColor = Colors.darkGray
        
        imageView.image = Images.Categories.plus
    }

}
