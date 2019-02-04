//
//  Created by Dmitry Ivanenko on 04/02/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import UIKit


class CategoryCell: UICollectionViewCell {

    private struct Constants {
        static let cornerRadius: CGFloat = 4
    }


    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var containerStackView: UIStackView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var amountLabel: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()

        layer.cornerRadius = Constants.cornerRadius

        titleLabel.font = Fonts.Rubik.Regular(size: 12)
        titleLabel.textColor = Colors.darkGray

        amountLabel.font = Fonts.Rubik.Regular(size: 11)
        amountLabel.textColor = Colors.blue
    }


    func setup(props: Props) {
        if props.isSelected {
            layer.borderColor = Colors.red.cgColor
            layer.borderWidth = 1
        } else {
            layer.borderColor = nil
            layer.borderWidth = 0
        }

        titleLabel.text = props.title
        imageView.image = props.image
        amountLabel.text = props.currentBalance
        amountLabel.isHidden = props.currentBalance == nil
    }

}


extension CategoryCell {
    struct Props {
        let title: String
        let image: UIImage
        let currentBalance: String?
        let isSelected: Bool
    }
}
