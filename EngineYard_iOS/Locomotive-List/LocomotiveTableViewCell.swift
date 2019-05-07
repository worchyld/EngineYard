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
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var productionCost: UILabel!
    @IBOutlet weak var incomeLabel: UILabel!
    @IBOutlet weak var noOrdersLabel: UILabel!
    @IBOutlet var lblCollection: [UILabel]!
    @IBOutlet var dieCollection: [UIImageView]!
    
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
        self.productionCost.text = formattedProduction
        self.incomeLabel.text = formattedIncome
        self.costLabel.text = formattedCost

        let _ = self.dieCollection.map({
            $0.isHidden = true
        })

        self.noOrdersLabel.text = "No orders"
        self.noOrdersLabel.isHidden = (deck.orderBook.existingOrderValues.count != 0)

        if (deck.orderBook.existingOrders.count > 0) {
            for (index, orderValue) in deck.orderBook.existingOrderValues.enumerated() {
                let asset = Die.asset(die: orderValue)

                guard let item = (self.dieCollection.filter({ (imgView) -> Bool in
                    return (imgView.tag == index)
                }).first) else {
                    return
                }

                item.image = UIImage(named: asset)
                item.isHidden = false
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
