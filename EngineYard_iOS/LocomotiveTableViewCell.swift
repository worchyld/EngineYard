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
        switch deck.color {
        case .green:
            let color = UIColor(red: 66/255, green: 230/255, blue: 149/255, alpha: 1)
            self.iconTrainImageView.tintColor = color
            break

        case .red:
            let color = UIColor.init(red: 245/255, green: 78/255, blue: 162/255, alpha: 1)
            self.iconTrainImageView.tintColor = color
            break

        case .yellow:
            let color = UIColor.init(red: 252/255, green: 227/255, blue: 138/255, alpha: 1)
            self.iconTrainImageView.tintColor = color
            break

        case .blue:
            let color = UIColor.init(red: 23/255, green: 234/255, blue: 217/255, alpha: 1)
            self.iconTrainImageView.tintColor = color
            break
        }
    }

    /*
    func applyHeaderColor(card: EngineCard) {

        switch card.engineColor {
        case .green:
            self.headerView.backgroundColor = UIColor.init(colorLiteralRed: 66/255, green: 230/255, blue: 149/255, alpha: 1)
            break
        case .red:
            self.headerView.backgroundColor = UIColor.init(colorLiteralRed: 245/255, green: 78/255, blue: 162/255, alpha: 1)
            break
        case .yellow:
            self.headerView.backgroundColor = UIColor.init(colorLiteralRed: 252/255, green: 227/255, blue: 138/255, alpha: 1)
            break
        case .blue:
            self.headerView.backgroundColor = UIColor.init(colorLiteralRed: 23/255, green: 234/255, blue: 217/255, alpha: 1)
            break
        }
    }
    */


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
