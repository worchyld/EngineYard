//
//  CardView.swift
//  EngineYard
//
//  Created by Amarjit on 03/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import UIKit

class CardView: UIView {

    @IBOutlet weak var trainIconView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var generationLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var productionLabel: UILabel!
    @IBOutlet weak var incomeLabel: UILabel!
    @IBOutlet var iconSidebarCollection: [UIImageView]!
    @IBOutlet weak var ordersLabel: UILabel!
    @IBOutlet var diceImageViewCollection: [UIImageView]!
    @IBOutlet weak var buyButton: UIButton!

    @IBAction func buyButtonDidPress(_ sender: UIButton) {
        print ("Do something here")
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
