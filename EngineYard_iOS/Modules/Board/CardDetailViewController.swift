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
class CardDetailViewController: UIViewController, Storyboarded {
    weak var coordinator: BoardCoordinator?
    var viewModel: CardViewModel!

    weak var cardDetailView: CardDetailView?

    lazy var formattedCost: String? = {
        guard let viewModel = self.viewModel else {
            return nil
        }
        let cost = viewModel.card.cost
        let costAsNumber = NSNumber(value: cost)
        let cache = NumberFormatCache.currencyRateFormatter
        return cache.string(from: costAsNumber) ?? "NaN"
    }()
    lazy var formattedProductionCost: String? = {
        guard let viewModel = self.viewModel else {
            return nil
        }
        let cost = viewModel.card.productionCost
        let costAsNumber = NSNumber(value: cost)
        let cache = NumberFormatCache.currencyRateFormatter
        return cache.string(from: costAsNumber) ?? "NaN"
    }()
    lazy var formattedIncome: String? = {
        guard let viewModel = self.viewModel else {
            return nil
        }
        let cost = viewModel.card.income
        let costAsNumber = NSNumber(value: cost)
        let cache = NumberFormatCache.currencyRateFormatter
        return cache.string(from: costAsNumber) ?? "NaN"
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Card view"

        //self.cardDetailView?.nameLabel?.text = "Lorem ipsum"
        guard let viewModel = self.viewModel else {
            return
        }

        self.configure(with: viewModel.card)
    }

    override func loadView() {
        super.loadView()

        let customView = CardDetailView.instantiate()

        self.view.addSubview(customView)
        NSLayoutConstraint.activate([
            customView.topAnchor.constraint(equalTo: self.view.topAnchor),
            customView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            customView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            customView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
        self.cardDetailView = customView
    }

    func configure(with card: Card) {
        let bgColor = UIColor.flat(color: card.color.flatColor, alpha: 0.45)

        guard let detailView = self.cardDetailView else {
            return
        }

        detailView.backgroundColor = bgColor

        detailView.nameLabel?.text = "\(card.name)".capitalizingFirstLetter()
        detailView.generationLabel?.text = "\(card.generation)".capitalizingFirstLetter() + " Generation"

        detailView.costLabel?.text = self.formattedCost ?? "NaN"
        detailView.productionLabel?.text = self.formattedProductionCost ?? "NaN"
        detailView.incomeLabel?.text = self.formattedIncome ?? "NaN"

        detailView.btnBuyBtnCollection.forEach { (btn) in
            btn.borderColor = UIColor.systemBlue
            btn.setTitleColor(.systemBlue, for: UIControl.State.normal)
            btn.setTitleColor(.systemGray, for: UIControl.State.disabled)
        }
    }

}
