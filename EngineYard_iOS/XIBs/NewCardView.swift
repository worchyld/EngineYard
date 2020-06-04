//
//  NewCardView.swift
//  EngineYard
//
//  Created by Amarjit on 04/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class NewCardView: NibView {
    
    @IBOutlet weak var headerStackView: UIStackView!

    override func layoutSubviews() {
         super.layoutSubviews()
         //manually set subview frames here
        let subView = UIView(frame: bounds)
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        subView.layer.cornerRadius = 8.0
        subView.backgroundColor = UIColor.white
        subView.layer.shadowColor = UIColor.systemGray.cgColor
        subView.layer.shadowOpacity = 1.0
        subView.layer.shadowOffset = .zero
        subView.layer.shadowRadius = 1.0
        insertSubview(subView, at: 0)
        

//        let backgroundView = UIView()
//        backgroundView.backgroundColor = UIColor.purple
//        backgroundView.translatesAutoresizingMaskIntoConstraints = false
//
//        // put background view as the most background subviews of stack view
//        headerStackView.insertSubview(backgroundView, at: 0)
//
//        // pin the background view edge to the stack view edge
//        NSLayoutConstraint.activate([
//            backgroundView.leadingAnchor.constraint(equalTo: headerStackView.leadingAnchor),
//            backgroundView.trailingAnchor.constraint(equalTo: headerStackView.trailingAnchor),
//            backgroundView.topAnchor.constraint(equalTo: headerStackView.topAnchor),
//            backgroundView.bottomAnchor.constraint(equalTo: headerStackView.bottomAnchor)
//        ])
    }
}
