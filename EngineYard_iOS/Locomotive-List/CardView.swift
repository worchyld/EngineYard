//
//  CardView.swift
//  EngineYard
//
//  Created by Amarjit on 22/12/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import UIKit

class CardViewModel : BaseViewModel {
    var deck: Deck?
}

class CardView: UIView {

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var bodyView: UIView!
    @IBOutlet weak var ordersView: UIView!

    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var productionCostLabel: UILabel!
    @IBOutlet weak var incomeLabel: UILabel!

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var generationLabel: UILabel!

    @IBOutlet weak var ordersLabel: UILabel!
    @IBOutlet weak var qtyLabel: UILabel!
    @IBOutlet weak var ownershipImageView: UIImageView!

    @IBOutlet var iconsOutletCollection: [UIImageView]!
    @IBOutlet var labelOutletCollection: [UILabel]!
    @IBOutlet var diceOutletCollection: [UIImageView]!

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 5.0
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.masksToBounds = true
        self.backgroundColor = UIColor.white
        if (self.iconsOutletCollection.count >  0)
        {
            for iconIV in self.iconsOutletCollection {
                iconIV.image = iconIV.image?.maskWithColor(color: .white)
            }
        }
        self.ownershipImageView.image = self.ownershipImageView.image?.maskWithColor(color: .green)
    }

    func configure(with deck: Deck) {
        // Setup UI
        let _ = self.labelOutletCollection.forEach { (label: UILabel) in
            label.sizeToFit()
            label.layoutIfNeeded()
        }

        let _ = self.iconsOutletCollection.forEach { (imageView: UIImageView) in
            imageView.sizeToFit()
            imageView.layoutIfNeeded()
        }

        let _ = self.diceOutletCollection.forEach { (imageView: UIImageView) in
            imageView.sizeToFit()
            imageView.layoutIfNeeded()
        }

        // Setup labels
        let genNumber = NSNumber(integerLiteral: deck.generation.rawValue)
        let costNumber = NSNumber(integerLiteral: deck.cost)
        let productionNumber = NSNumber(integerLiteral: deck.productionCost)
        let incomeNumber = NSNumber(integerLiteral: deck.income)

        self.nameLabel.text = deck.name
        self.generationLabel.text = NSLocalizedString("Generation \(genNumber)", comment: "Train generation number")
        self.costLabel.text = ObjectCache.currencyRateFormatter.string(from: costNumber)
        self.productionCostLabel.text = ObjectCache.currencyRateFormatter.string(from: productionNumber)
        self.incomeLabel.text = ObjectCache.currencyRateFormatter.string(from: incomeNumber)


    }


}
