//
//  CardDetailView.swift
//  EngineYard
//
//  Created by Amarjit on 05/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation
import UIKit

class CardDetailView: UIView {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var generationLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var productionLabel: UILabel!
    @IBOutlet weak var incomeLabel: UILabel!
    @IBOutlet var btnBuyBtnCollection: [BorderedButton]!

    static func nib() -> UINib {
        return UINib(nibName: "CardDetailView", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    

    @IBAction func btnBuyDidPress(_ sender: UIButton) {
        print("You pressed buy on tag: \(sender.tag)")
    }
}
