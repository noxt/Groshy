//
//  Created by Dmitry Ivanenko on 04/02/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import UIKit


final class CategoryCell: UICollectionViewCell {

    // MARK: - Types

    private struct Constants {
        static let cornerRadius: CGFloat = 4
    }


    // MARK: - IBOutlet

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var containerStackView: UIStackView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var amountLabel: UILabel!


    // MARK: - Lifetime

    override func awakeFromNib() {
        super.awakeFromNib()

        layer.cornerRadius = Constants.cornerRadius

        titleLabel.font = Fonts.Rubik.Regular(size: 12)
        titleLabel.textColor = Colors.darkGray

        amountLabel.font = Fonts.Rubik.Regular(size: 11)
        amountLabel.textColor = Colors.blue
    }


    // MARK: - Public methods

    func setup(props: CategoriesPropsState.CategoryInfo) {
        if props.isSelected {
            layer.borderColor = Colors.red.cgColor
            layer.borderWidth = 1.5
        } else {
            layer.borderColor = nil
            layer.borderWidth = 0
        }

        titleLabel.text = props.title
        imageView.image = props.icon
        amountLabel.text = props.currentBalance
        amountLabel.isHidden = props.currentBalance == nil
    }

}
