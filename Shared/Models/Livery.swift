//
//  Livery.swift
//  EngineYard
//
//  Created by Amarjit on 06/11/2020.
//

import Foundation

// Color of engine
enum Livery: NSInteger, Codable, CaseIterable {
    case green = 1, red, yellow, blue
}

// Stringify description
extension Livery: CustomStringConvertible {
    var description: String {
        get {
            switch self {
            case .green:
                return "green"
            case .blue:
                return "blue"
            case .red:
                return "red"
            case .yellow:
                return "yellow"
            }
        }
    }
}

// Asset image for each colour engine
extension Livery {
    public var iconAsset : String {
        get {
            switch self {
            case .green:
                return "icon-train-green"
            case .red:
                return "icon-train-red"
            case .blue:
                return "icon-train-yellow"
            case .yellow:
                return "icon-train-blue"
            }
        }
    }
}
