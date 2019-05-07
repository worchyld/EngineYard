//
//  PlayerHUDView.swift
//  EngineYard
//
//  Created by Amarjit on 27/11/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import UIKit

class PlayerHUDView: UIView {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var cashLabel: UILabel!
    @IBOutlet weak var portfolioLabel: UILabel!
    @IBOutlet weak var activePlayerView: UIView!
    @IBOutlet var labelCollection: [UILabel]!

    func configure(with player: Player, isActivePlayer: Bool = false) {
        labelCollection.forEach { (label) in
            label.sizeToFit()
        }

        let cash: NSNumber = NSNumber(integerLiteral: player.cash)
        let formattedCash = ObjectCache.currencyRateFormatter.string(from: cash)!

        self.cashLabel.text = "\(formattedCash)"
        self.portfolioLabel.text = "\(player.hand.size)"

        self.activePlayerView.isHidden = !(isActivePlayer)

        guard let assetName = player.asset else {
            return
        }
        guard let img = UIImage(named: assetName) else {
            return
        }
        self.avatarImageView.maskCircle(anyImage: img)
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
