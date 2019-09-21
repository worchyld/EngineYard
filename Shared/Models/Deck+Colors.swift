//
//  Deck+Colors.swift
//  EngineYard
//
//  Created by Amarjit on 21/09/2019.
//  Copyright © 2019 Amarjit. All rights reserved.
//

import UIKit

extension Deck.Color {

    func color() -> UIColor {
        switch self {
            case .green:
            return UIColor.flat(color: .Emerald)

            case .blue:
            return UIColor.flat(color: .PeterRiver)

            case .red:
            return UIColor.flat(color: .Alizarin)

            case .yellow:
            return UIColor.flat(color: .SunFlower)
        }
    }
}
