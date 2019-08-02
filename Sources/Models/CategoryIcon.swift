//
//  Created by Dmitry Ivanenko on 24/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import UIKit


extension Category {
    enum Icon: String, CaseIterable, Codable {
        case car
        case entertaiment
        case presents
        case products
        case restaurants
        case shops
        case baby
        case bus
        case chair
        case computer
        case cosmetics
        case discount
        case dumbbell
        case farm
        case file
        case fireworks
        case graduation
        case health
        case home
        case microphone
        case music
        case paw
        case plane
        case puzzle
        case settings
        case sneaker
        case tShirt
        case taxi
        case telephone
        case toy
        case video

        static func random() -> Icon {
            return Icon.allCases.randomElement()!
        }
    }
}


extension Category.Icon {
    var image: UIImage {
        switch self {
        case .car:
            return Images.Categories.car
        case .entertaiment:
            return Images.Categories.entertaiment
        case .presents:
            return Images.Categories.presents
        case .products:
            return Images.Categories.products
        case .restaurants:
            return Images.Categories.restaurants
        case .shops:
            return Images.Categories.shops
        case .baby:
            return Images.Categories.baby
        case .bus:
            return Images.Categories.bus
        case .chair:
            return Images.Categories.chair
        case .computer:
            return Images.Categories.computer
        case .cosmetics:
            return Images.Categories.cosmetics
        case .discount:
            return Images.Categories.discount
        case .dumbbell:
            return Images.Categories.dumbbell
        case .farm:
            return Images.Categories.farm
        case .file:
            return Images.Categories.file
        case .fireworks:
            return Images.Categories.fireworks
        case .graduation:
            return Images.Categories.graduation
        case .health:
            return Images.Categories.health
        case .home:
            return Images.Categories.home
        case .microphone:
            return Images.Categories.microphone
        case .music:
            return Images.Categories.music
        case .paw:
            return Images.Categories.paw
        case .plane:
            return Images.Categories.plane
        case .puzzle:
            return Images.Categories.puzzle
        case .settings:
            return Images.Categories.settings
        case .sneaker:
            return Images.Categories.sneaker
        case .tShirt:
            return Images.Categories.tShirt
        case .taxi:
            return Images.Categories.taxi
        case .telephone:
            return Images.Categories.telephone
        case .toy:
            return Images.Categories.toy
        case .video:
            return Images.Categories.video
        }
    }
}
