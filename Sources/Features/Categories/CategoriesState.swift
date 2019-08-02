//
//  Created by Dmitry Ivanenko on 03/02/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation


extension CategoriesFeature {
    struct State: Codable {

        var selectedCategory: Category.ID?
        var categories: [Category.ID : Category]
        var sortOrder: [Category.ID]
        var isLoading: Bool
        var error: String?


        static let initial = State(
            selectedCategory: nil,
            categories: [:],
            sortOrder: [],
            isLoading: false,
            error: nil
        )

    }
}
