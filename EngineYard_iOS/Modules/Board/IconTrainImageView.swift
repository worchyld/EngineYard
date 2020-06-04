//
//  IconTrainImageView.swift
//  EngineYard
//
//  Created by Amarjit on 04/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation
import UIKit

enum TrainIcon: String {
    case black = "icon-train"
    case white = "icon-train-w"

    var image: UIImage? {
        let name = self.rawValue
        return UIImage(named: name)
    }
}

class IconTrainImageView: UIImageView {
    override init(image: UIImage?) {
        super.init(image: image)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
