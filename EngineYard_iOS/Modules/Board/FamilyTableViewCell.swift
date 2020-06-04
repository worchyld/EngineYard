//
//  FamilyTableViewCell.swift
//  EngineYard
//
//  Created by Amarjit on 04/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import UIKit

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

    func configure(with card: Card) {
        let bgColor = UIColor.flat(color: card.color.flatColor)
        self.backgroundColor = bgColor
        self.layer.opacity = 0.65

        let number: NSNumber = NSNumber(value: card.cost)
        let cache = NumberFormatCache.currencyRateFormatter
        let formattedCash: String = cache.string(from: number) ?? "NaN"

        self.nameLabel?.text = "\(card.name)".capitalizingFirstLetter()
        self.generationLabel?.text = "\(card.generation)".capitalizingFirstLetter() + " Generation"
        self.costLabel?.text = formattedCash

        self.nameLabel?.sizeToFit()
        self.generationLabel?.sizeToFit()
        self.costLabel?.sizeToFit()
    }
}
