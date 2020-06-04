//
//  NewCardView.swift
//  EngineYard
//
//  Created by Amarjit on 04/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation
import UIKit

class NewCardView: UIView {

    @IBOutlet weak var headerStackView: UIStackView!

    override func layoutSubviews() {
         super.layoutSubviews()
         //manually set subview frames here
        let subView = UIView(frame: bounds)
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        subView.layer.cornerRadius = 6.0
        subView.backgroundColor = UIColor.white
        subView.layer.shadowColor = UIColor.systemGray.cgColor
        subView.layer.shadowOpacity = 1.0
        subView.layer.shadowOffset = .zero
        subView.layer.shadowRadius = 1.0
        insertSubview(subView, at: 0)

        self.headerStackView.addBackground(color: .flat(color: .OceanGreen))
    }
}
