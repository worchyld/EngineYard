//
//  Storyboarded.swift
//  EngineYard
//
//  Created by Amarjit on 20/09/2019.
//  Copyright © 2019 Amarjit. All rights reserved.
//

import Foundation
import UIKit

enum ListOfStoryboards: String {
    case main = "Main"
}

protocol Storyboarded {
    static func instantiate(_ storyboardId: ListOfStoryboards) -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiate(_ storyboardId: ListOfStoryboards) -> Self {
        let id = String(describing: self)

        var storyboard = UIStoryboard()

        switch storyboardId {
        case .main:
            storyboard = UIStoryboard(name: ListOfStoryboards.main.rawValue,
                                      bundle: Bundle.main)
        }

        return storyboard.instantiateViewController(withIdentifier: id) as! Self
    }
}
