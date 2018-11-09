//
//  NewGamePlayerCollectionViewCell.swift
//  EngineYard
//
//  Created by Amarjit on 05/10/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import UIKit

class NewGamePlayerCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var avatarImgView: UIImageView!
    @IBOutlet weak var btnPlayerState: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()

        guard let img = UIImage(named: "avt_1") else {
            return
        }
        self.avatarImgView.maskCircle(anyImage: img)
    }

    @IBAction func togglePlayerState(_ sender: Any) {
        self.btnPlayerState.isSelected = !self.btnPlayerState.isSelected
    }
}
