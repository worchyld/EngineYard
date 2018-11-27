//
//  DeckColors.swift
//  EngineYard
//
//  Created by Amarjit on 27/11/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import Foundation
import UIKit

extension EngineColor {

    static let themeGreen = UIColor(red: 66/255, green: 230/255, blue: 149/255, alpha: 1)
    static let themeRed = UIColor.init(red: 245/255, green: 78/255, blue: 162/255, alpha: 1)
    static let themeYellow = UIColor.init(red: 252/255, green: 227/255, blue: 138/255, alpha: 1)
    static let themeBlue = UIColor.init(red: 23/255, green: 234/255, blue: 217/255, alpha: 1)

    public static func theme(deck: Deck) -> UIColor {
        switch deck.color {
        case .green:
            return themeGreen
        case .red:
            return themeRed
        case .yellow:
            return themeYellow
        case .blue:
            return themeBlue
        }
    }
    
}
