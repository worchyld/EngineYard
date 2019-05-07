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
            imageView.isHidden = false
        }
        self.headerView.backgroundColor = EngineColor.getColor(color: deck.color)
        self.ownershipImageView.isHidden = true

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
        self.ordersLabel.text = NSLocalizedString("Orders", comment: "Orders title")

        if (deck.orderBook.existingOrders.count > 0) {
            for (index, orderValue) in deck.orderBook.existingOrderValues.enumerated() {
                let asset = Die.asset(die: orderValue)

                guard let item = (self.diceOutletCollection.filter({ (imgView) -> Bool in
                    return (imgView.tag == index)
                }).first) else {
                    return
                }

                item.image = UIImage(named: asset)
                item.isHidden = false
            }
        }
    }

    func applyHeaderColor(deck: Deck) {
        /*
        switch deck.color {
        case .green:
            //self.headerView.backgroundColor = UIColor.init(colorLiteralRed: 66/255, green: 230/255, blue: 149/255, alpha: 1)
            break
        case .red:
            //self.headerView.backgroundColor = UIColor.init(colorLiteralRed: 245/255, green: 78/255, blue: 162/255, alpha: 1)
            break
        case .yellow:
            //self.headerView.backgroundColor = UIColor.init(colorLiteralRed: 252/255, green: 227/255, blue: 138/255, alpha: 1)
            break
        case .blue:
            //self.headerView.backgroundColor = UIColor.init(colorLiteralRed: 23/255, green: 234/255, blue: 217/255, alpha: 1)
            break
        } */
    }

    public static func applyDropShadow(deck: Deck, forView: UIView) {
        let alpha: CGFloat = 1.0

        var color = UIColor(red: 192/255, green: 192/255, blue: 192/255, alpha: alpha)

        switch deck.color {
        case .green:
            color = UIColor(red: 59/255, green: 178/255, blue: 184/255, alpha: alpha)
            break
        case .red:
            color = UIColor(red: 255/255, green: 118/255, blue: 118/255, alpha: alpha)
            break
        case .yellow:
            color = UIColor(red: 243/255, green: 129/255, blue: 129/255, alpha: alpha)
            break
        case .blue:
            color = UIColor(red: 96/255, green: 120/255, blue: 234/255, alpha: alpha)
            break
        }

        forView.layer.masksToBounds = false
        forView.layer.shadowColor = color.cgColor
        forView.layer.shadowOpacity = 0.25
        forView.layer.shadowOffset = CGSize(width: 5, height: 5)
        forView.layer.shadowRadius = 5
        forView.layer.shadowPath = UIBezierPath(rect: forView.bounds).cgPath
        forView.layer.shouldRasterize = true
        forView.layer.rasterizationScale = UIScreen.main.scale
    }


}
