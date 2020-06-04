//
//  CardView.swift
//  EngineYard
//
//  Created by Amarjit on 03/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation
import UIKit

class CardView:  UIView  {

    @IBOutlet weak var trainIcon: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var generationLabel: UILabel!

    @IBOutlet weak var costLabel: UILabel!

    @IBOutlet weak var productionLabel: UILabel!

    @IBOutlet weak var incomeLabel: UILabel!

    @IBOutlet weak var buyBtn: UIButton!

    @IBAction func btnBuyDidPress(_ sender: UIButton) {
    }
    @IBOutlet var diceCollection: [UIImageView]!

    @IBOutlet weak var orderLabel: UILabel!

    @IBOutlet weak var designIcon: UIImageView!

    @IBOutlet weak var cogIcon: UIImageView!

    @IBOutlet weak var coinsIcon: UIImageView!


}
