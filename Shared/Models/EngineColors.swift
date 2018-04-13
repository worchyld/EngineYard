//
//  EngineColors.swift
//  EngineYard
//
//  Created by Amarjit on 26/12/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import Foundation
import UIKit

enum EngineColor: Int {
    case green = 1  // Passenger
    case red    // Fast
    case yellow // Freight
    case blue   // Special

    static let allRawValues = EngineColor.green.rawValue...EngineColor.blue.rawValue
    static let allValues = Array(allRawValues.map{ EngineColor(rawValue: $0)! })
}

extension EngineColor {
    func getColorForEngine() -> UIColor {
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
