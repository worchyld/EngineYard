//
//  LocomotiveTableViewCell.swift
//  EngineYard
//
//  Created by Amarjit on 27/11/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import UIKit

class LocomotiveTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var generationLabel: UILabel!
    @IBOutlet weak var productionCostLabel: UILabel!
    @IBOutlet weak var incomeLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!

    func configure(with deck: Deck) {
        let productionCost = NSNumber(integerLiteral: deck.productionCost)
        let income = NSNumber(integerLiteral: deck.income)
        let cost = NSNumber(integerLiteral: deck.cost)
        self.nameLabel.text = deck.name
        self.generationLabel.text = "\(deck.generation)"
        self.productionCostLabel.text = ObjectCache.currencyRateFormatter.string(from: productionCost)!
        self.incomeLabel.text = ObjectCache.currencyRateFormatter.string(from: income)!
        self.costLabel.text = ObjectCache.currencyRateFormatter.string(from: cost)!

        self.nameLabel.sizeToFit()
        self.generationLabel.sizeToFit()
        self.productionCostLabel.sizeToFit()
        self.incomeLabel.sizeToFit()
        self.costLabel.sizeToFit()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.updateConstraints()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
