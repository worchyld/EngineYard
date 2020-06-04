//
//  IconTrainImageView.swift
//  EngineYard
//
//  Created by Amarjit on 04/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class IconTrainImageView: UIImageView {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setup()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setup()
    }

    private func setup() {
//        if let nibView = Bundle.main.loadNibNamed("IconTrainImageView", owner: self, options: nil)?.first as? UIView {
//            addSubview(nibView)
//            self.setNeedsDisplay()
//        }
    }

//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        if let nibView = Bundle.main.loadNibNamed("IconTrainImageView", owner: self, options: nil)?.first as? UIView {
//            addSubview(nibView)
//        }
//    }
}
