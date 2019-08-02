//
//  Created by Dmitry Ivanenko on 24/07/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation
import Command


struct CreateCategoryScreenProps: Equatable {
    let title: String?
    let icon: Category.Icon?
    let onSave: CommandOf<Category>
    let categoryID: Category.ID?
}
