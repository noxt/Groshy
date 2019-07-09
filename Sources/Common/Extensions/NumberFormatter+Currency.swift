//
//  NumberFormatter+Currency.swift
//  Groshy
//
//  Created by Dmitry Ivanenko on 08/07/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import Foundation


extension NumberFormatter {
    
    static var currency: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter
    }
    
    static var byn: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currencyAccounting
        numberFormatter.currencyCode = "BYN"
        return numberFormatter
    }

}
