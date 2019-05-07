//
//  Card+Colors.swift
//  EngineYard
//
//  Created by Amarjit on 15/04/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import Foundation
import UIKit

extension EngineColor {
    public static func getColor(color: EngineColor) -> UIColor {
        switch color {
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
