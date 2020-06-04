//
//  CardFamilyTableViewCell.swift
//  EngineYard
//
//  Created by Amarjit on 04/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import UIKit

struct CardFamilyViewModel {
    let nameTxt: String
    let colorTxt: String
    let costTxt: String
    let generationTxt: String
    let productionTxt: String
    let incomeTxt: String

    init(with position: BoardPosition) {
        let cache = NumberFormatCache.currencyRateFormatter

        self.nameTxt = String(describing: position.name)
        self.colorTxt = String(describing: position.color)
        self.generationTxt = String(describing: position.generation)

        let card = Card.init(cost: position.cost,
                             color: position.color,
                             generation: position.generation)

        let numberCost = NSNumber(value: card.cost)
        let numberProduction = NSNumber(value: card.productionCost)
        let numberIncome = NSNumber(value: card.income)

        // Cash display text
        self.costTxt = cache.string(from: numberCost) ?? "N/A"
        self.productionTxt = cache.string(from: numberProduction) ?? "N/A"
        self.incomeTxt = cache.string(from: numberIncome) ?? "N/A"
    }
}

class CardFamilyTableViewCell: UITableViewCell {
    var viewModel: CardFamilyViewModel!

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var generationLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var productionLabel: UILabel!
    @IBOutlet weak var incomeLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        guard let viewModel = self.viewModel else {
            return
        }

        self.nameLabel.text = viewModel.nameTxt
        self.generationLabel.text = viewModel.generationTxt
        self.costLabel.text = viewModel.costTxt
        self.productionLabel.text = viewModel.productionTxt
        self.incomeLabel.text = viewModel.incomeTxt

        self.nameLabel.sizeToFit()
        self.generationLabel.sizeToFit()
        self.costLabel.sizeToFit()
        self.productionLabel.sizeToFit()
        self.incomeLabel.sizeToFit()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
