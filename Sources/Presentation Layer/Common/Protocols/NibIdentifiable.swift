//
//  Created by Dmitry Ivanenko on 19/01/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import UIKit


protocol NibIdentifiable {
    static var nibIdentifier: String { get }
    static func instantiateFromNib() -> Self
}


extension NibIdentifiable {
    static var nib: UINib {
        return UINib(nibName: nibIdentifier, bundle: nil)
    }
}


extension UIView: NibIdentifiable {
    static var nibIdentifier: String {
        return String(describing: self)
    }
}


extension NibIdentifiable where Self: UIView {
    static func instantiateFromNib() -> Self {
        return Bundle.main.loadNibNamed(nibIdentifier, owner: nil, options: nil)!.first as! Self
    }
}
