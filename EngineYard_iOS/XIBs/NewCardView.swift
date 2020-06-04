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

    override func draw(_ layer: CALayer, in ctx: CGContext) {
        super.draw(layer, in: ctx)

        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.purple

        backgroundView.translatesAutoresizingMaskIntoConstraints = false

        // put background view as the most background subviews of stack view
        headerStackView.insertSubview(backgroundView, at: 0)

        // pin the background view edge to the stack view edge
        NSLayoutConstraint.activate([
            backgroundView.leadingAnchor.constraint(equalTo: headerStackView.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: headerStackView.trailingAnchor),
            backgroundView.topAnchor.constraint(equalTo: headerStackView.topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: headerStackView.bottomAnchor)
        ])
    }
}
