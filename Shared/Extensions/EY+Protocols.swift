//
//  EY+Protocols.swift
//  EngineYard
//
//  Created by Amarjit on 16/11/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import Foundation
import UIKit

@objc protocol ConfigureCellDelegate {
    @objc optional func configure(cell: UITableViewCell, at indexPath:IndexPath)
    @objc optional func configure(cell: UICollectionViewCell, at indexPath: IndexPath)
}


protocol ReusableView {
    static var reuseIdentifier: String { get }
}

extension ReusableView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReusableView {}
