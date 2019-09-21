//
//  CardColor.swift
//  EngineYard
//
//  Created by Amarjit on 19/09/2019.
//  Copyright © 2019 Amarjit. All rights reserved.
//

import Foundation
import UIKit

public enum DeckType: Int {
    case green = 1  // Passenger
    case red    // Fast
    case yellow // Freight
    case blue   // Special

    static let allRawValues = DeckType.green.rawValue...DeckType.blue.rawValue
    static let allValues = Array(allRawValues.map{ DeckType(rawValue: $0)! })
}

extension DeckType {

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
