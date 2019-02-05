//
//  Created by Dmitry Ivanenko on 03/02/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation


extension CategoriesFeature {

    struct State: Codable {

        let categories: [Category.ID : Category]
        let sortOrder: [Category.ID]
        let isLoading: Bool
        let error: String?


        static let initial = State(
            categories: [:],
            sortOrder: [],
            isLoading: false,
            error: nil
        )

    }

}
