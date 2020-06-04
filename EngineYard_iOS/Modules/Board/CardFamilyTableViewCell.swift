//
//  CardFamilyTableViewCell.swift
//  EngineYard
//
//  Created by Amarjit on 04/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import UIKit

// Call for a board position
class CardFamilyTableViewCell: UITableViewCell {
    var boardPosition: BoardPosition!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setup()
    }

    lazy var nameLabel: UILabel = {
        let frame = CGRect(x: 0, y: 0, width: 80, height: 14)
        let lbl = UILabel(frame: frame)
        lbl.text = "\(self.boardPosition.color)"
        lbl.font = .boldSystemFont(ofSize: 12)
        lbl.sizeToFit()
        return lbl
    }()

    lazy var generationLabel: UILabel = {
        let frame = CGRect(x: 0, y: 18, width: 80, height: 14)
        let lbl = UILabel(frame: frame)
        lbl.text = "\(self.boardPosition.generation)"
        lbl.font = .systemFont(ofSize: 10)
        lbl.sizeToFit()
        return lbl
    }()


    func setup() {
        self.addSubview(nameLabel)
        self.addSubview(generationLabel)

        /*
        let stackView = UIStackView(frame: self.frame)
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 2.0

        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(generationLabel)
        stackView.layoutIfNeeded()

        self.addSubview(stackView)*/
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
