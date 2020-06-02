//
//  Storyboarded.swift
//  EngineYard
//
//  Created by Amarjit on 20/09/2019.
//  Copyright © 2019 Amarjit. All rights reserved.
//

import Foundation
import UIKit

public enum StoryboardRef: String {
    case main = "Main"
    case board = "Board"
    case winner = "Winner"
}

protocol Storyboarded {
    static func instantiate(_ storyboardId: StoryboardRef) -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiate(_ storyboardId: StoryboardRef) -> Self {
        let id = String(describing: self)

        var storyboard = UIStoryboard()

        switch storyboardId {
        case .main:
            storyboard = UIStoryboard(name: StoryboardRef.main.rawValue, bundle: Bundle.main)

        case .board:
            storyboard = UIStoryboard(name: StoryboardRef.board.rawValue, bundle: Bundle.main)

        case .winner:
            storyboard = UIStoryboard(name: StoryboardRef.winner.rawValue, bundle: Bundle.main)
        }

        return storyboard.instantiateViewController(withIdentifier: id) as! Self
    }
}
