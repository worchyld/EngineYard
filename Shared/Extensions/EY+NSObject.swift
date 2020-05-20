//
//  EY+NSObject.swift
//  EngineYard
//
//  Created by Amarjit on 20/05/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

extension NSObject {
    var theClassName: String {
        return NSStringFromClass(type(of: self)) as String
    }
}
