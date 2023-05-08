//
//  EngineColours.swift
//  EngineYard
//
//  Created by Amarjit on 13/04/2023.
//

import Foundation

// Trains have a colour
enum EngineColor: Int, Codable, CaseIterable, Equatable  {
    case green = 1, red, yellow, blue
    
    static let allCases: AllCases = [
        .green, .red, .yellow, .blue
    ]
}

// Stringify
extension EngineColor: CustomStringConvertible {
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

// Art
extension EngineColor {
    public var icon : String {
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

