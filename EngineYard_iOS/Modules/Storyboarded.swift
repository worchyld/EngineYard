//
//  Storyboarded.swift
//  EngineYard
//
//  Created by Amarjit on 20/09/2019.
//  Copyright © 2019 Amarjit. All rights reserved.
//

import Foundation
import UIKit

public enum Storyboard: String {
    case main = "Main"
    case winner = "Winner"
}

protocol Storyboarded {
    static func instantiate(_ storyboardId: Storyboard) -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiate(_ storyboardId: Storyboard) -> Self {
        let id = String(describing: self)

        var storyboard = UIStoryboard()

        switch storyboardId {
        case .main:
            storyboard = UIStoryboard(name: Storyboard.main.rawValue, bundle: Bundle.main)

        case .winner:
            storyboard = UIStoryboard(name: Storyboard.winner.rawValue, bundle: Bundle.main)
        }

        return storyboard.instantiateViewController(withIdentifier: id) as! Self
    }
}
