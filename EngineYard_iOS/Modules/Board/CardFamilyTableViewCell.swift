//
//  CardFamilyTableViewCell.swift
//  EngineYard
//
//  Created by Amarjit on 04/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import UIKit

struct CardFamilyViewModel {
    let name: String
    let color: String
    let cost: String
    let generation: String
    let production: String
    let income: String

    init(with position: BoardPosition) {
        self.name = String(describing: position.name)
        self.color = String(describing: position.color)
        self.generation = String(describing: position.generation)
        self.cost = "$" + String(describing: position.cost)

        let card = Card.init(cost: position.cost,
                             color: position.color,
                             generation: position.generation)

        self.production = "$" + String(describing: card.income)
        self.income = "$" + String(describing: card.income)
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
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
