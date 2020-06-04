//
//  EY+String.swift
//  EngineYard
//
//  Created by Amarjit on 13/05/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

extension String {
    func ucFirst() -> String {
        return self.capitalizingFirstLetter()
    }

    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
