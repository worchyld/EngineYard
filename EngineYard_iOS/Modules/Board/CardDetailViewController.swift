//
//  CardDetailViewController.swift
//  EngineYard
//
//  Created by Amarjit on 03/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation
import UIKit

// Show a single card
class CardDetailViewController: UIViewController, NibViewController, Storyboarded {
    typealias ViewType = NewCardView

    @IBOutlet weak var cardView: NewCardView!

    weak var coordinator: BoardCoordinator?
    var viewModel: CardViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Card view"
        self.cardView.layoutIfNeeded()

        NSLayoutConstraint.activate([
            cardView.widthAnchor.constraint(equalToConstant: 155),
            cardView.heightAnchor.constraint(equalToConstant: 200),
            cardView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            cardView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
        self.view.setNeedsDisplay()
    }
}
