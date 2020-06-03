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
    typealias ViewType = CardView

    weak var coordinator: BoardCoordinator?
    var viewModel: CardViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Card view"
    }

    func setup(with cardView: CardView) {
        //ui.nameLabel.text = cardView.nameLabel?.text
        //ui.generationLabel.text = cardView.generationLabel?.text
        let card = self.viewModel.card
        cardView.nameLabel.text = self.viewModel.card.name
        cardView.generationLabel.text = String(describing: card.generation)
        cardView.costLabel.text = String(describing: "$\(card.cost)")
        cardView.productionLabel.text = ("$\(card.productionCost)")
        cardView.incomeLabel.text = ("$\(card.income)")
        cardView.buyBtn.setTitle("Buy $\(card.cost)", for: UIControl.State.normal)
    }
}
