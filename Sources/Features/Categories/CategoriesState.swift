//
//  Created by Dmitry Ivanenko on 03/02/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation


extension CategoriesFeature {
    struct State: Codable {

        let selectedCategory: Category.ID?
        let categories: [Category.ID : Category]
        let sortOrder: [Category.ID]
        let isLoading: Bool
        let error: String?


        static let initial = State(
            selectedCategory: nil,
            categories: [:],
            sortOrder: [],
            isLoading: false,
            error: nil
        )

    }
}
