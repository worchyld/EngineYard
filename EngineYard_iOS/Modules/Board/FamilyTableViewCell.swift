//
//  FamilyTableViewCell.swift
//  EngineYard
//
//  Created by Amarjit on 04/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import UIKit


struct FamilyViewModel {
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

class FamilyTableViewCell: UITableViewCell {
    @IBOutlet weak var iconTrainImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var generationLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    //@IBOutlet weak var productionLabel: UILabel!
    //@IBOutlet weak var incomeLabel: UILabel!

    static var reuseIdentifier: String = "FamilyCellID"
    static func nib() -> UINib {
        return UINib(nibName: "FamilyTableViewCell", bundle: Bundle.main)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure() {
        self.nameLabel?.text = "Name"
        self.generationLabel?.text = "Generation"
        self.costLabel?.text = "Cost"

        self.nameLabel?.sizeToFit()
        self.generationLabel?.sizeToFit()
        self.costLabel?.sizeToFit()

        //self.productionLabel.text = viewModel.productionTxt
        //self.incomeLabel.text = viewModel.incomeTxt
        //self.productionLabel.sizeToFit()
        //self.incomeLabel.sizeToFit()
    }
}
