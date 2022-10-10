//
//  Livery.swift
//  EngineYard
//
//  Created by Amarjit on 06/11/2020.
//

import Foundation

// Color of engine
enum Livery: NSInteger, Codable, CaseIterable, Equatable {
    case green = 1, red, yellow, blue
}

// Stringify description
extension Livery: CustomStringConvertible {
    var description: String {
        get {
            switch self {
            case .green: return "green"
            case .red: return "red"
            case .yellow: return "yellow"
            case .blue: return "blue"
            }
        }
    }
}

// Asset image for each colour engine
extension Livery {
    public var iconAsset : String {
        get {
            switch self {
            case .green: return "icon-train-green"
            case .red: return "icon-train-red"
            case .yellow: return "icon-train-yellow"
            case .blue: return "icon-train-blue"
            }
        }
    }
}
