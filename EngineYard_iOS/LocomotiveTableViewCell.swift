//
//  LocomotiveTableViewCell.swift
//  EngineYard
//
//  Created by Amarjit on 27/11/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import UIKit

class LocomotiveTableViewCell: UITableViewCell {

    @IBOutlet weak var iconTrainImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var generationLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet var lblCollection: [UILabel]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lblCollection.forEach { (label) in
            label.sizeToFit()
        }
    }

    func configure(with deck: Deck) {

        let cost = NSNumber(integerLiteral: deck.cost)
        let production = NSNumber(integerLiteral: deck.productionCost)
        let income = NSNumber(integerLiteral: deck.income)

        let formattedCost = ObjectCache.currencyRateFormatter.string(from: cost)!
        let formattedProduction = ObjectCache.currencyRateFormatter.string(from: production)!
        let formattedIncome = ObjectCache.currencyRateFormatter.string(from: income)!

        self.nameLabel.text = deck.name
        self.generationLabel.text = "Generation: #\(deck.generation)"
        self.infoLabel.text = "\(formattedCost) / \(formattedProduction) / \(formattedIncome)"

        tintTrainIcon(deck: deck)
    }

    func tintTrainIcon(deck: Deck) {
        //self.backgroundColor = EngineColor.getColorForEngine(deck.color)()
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
