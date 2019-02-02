//
//  Created by Dmitry Ivanenko on 24/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import UIKit


extension Category {
    enum Icon {
        case car
        case entertaiment
        case healt
        case presents
        case products
        case restaurants
        case shops
    }
}


extension Category.Icon {
    var image: UIImage {
        switch self {
        case .car:
            return Images.Categories.car
        case .entertaiment:
            return Images.Categories.entertaiment
        case .healt:
            return Images.Categories.healt
        case .presents:
            return Images.Categories.presents
        case .products:
            return Images.Categories.products
        case .restaurants:
            return Images.Categories.restaurants
        case .shops:
            return Images.Categories.shops
        }
    }
}
