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
    let generation: String

    init(with position: BoardPosition) {
        self.name = String(describing: position.color)
        self.generation = String(describing: position.generation)
    }
}


// Call for a board position
class CardFamilyTableViewCell: UITableViewCell {
    var viewModel: CardFamilyViewModel?

    @IBOutlet weak var trainIcon: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var generationLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var productionLabel: UILabel!
    @IBOutlet weak var incomeLabel: UILabel!

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setup()
    }

    /*
    lazy var trainIcon: UIImageView = {
        let image = UIImage(named: TrainIcon.black.rawValue)
        let iv = UIImageView(image: image)
        iv.sizeToFit()
        iv.clipsToBounds = true
        return iv
    }()

    lazy var nameLabel: UILabel = {
        let frame = CGRect(x: 0, y: 0, width: 80, height: 14)
        let lbl = UILabel(frame: frame)
        lbl.text = "Name"
        lbl.numberOfLines = 0
        lbl.adjustsFontSizeToFitWidth = true
        lbl.font = .boldSystemFont(ofSize: 12)
        lbl.sizeToFit()
        return lbl
    }()

    lazy var generationLabel: UILabel = {
        let frame = CGRect(x: 0, y: 20, width: 80, height: 14)
        let lbl = UILabel(frame: frame)
        lbl.text = "Generation"
        lbl.numberOfLines = 0
        lbl.adjustsFontSizeToFitWidth = true
        lbl.font = .systemFont(ofSize: 10)
        lbl.sizeToFit()
        return lbl
    }()
    */
    
    private func setup() {
        /*
        contentView.addSubview(self.trainIcon)
        contentView.addSubview(self.nameLabel)
        contentView.addSubview(self.generationLabel)

        // Train icon constraints
        self.trainIcon.translatesAutoresizingMaskIntoConstraints = false
        self.trainIcon.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        self.trainIcon.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        self.trainIcon.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.trainIcon.widthAnchor.constraint(equalTo: self.trainIcon.heightAnchor, multiplier: 1, constant: 1).isActive = true

        self.nameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        self.nameLabel.leadingAnchor.constraint(equalTo: self.trainIcon.trailingAnchor, constant: 20).isActive = true
        self.nameLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        self.nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true

        self.generationLabel.translatesAutoresizingMaskIntoConstraints = false
        self.generationLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        self.generationLabel.leadingAnchor.constraint(equalTo: self.nameLabel.trailingAnchor, constant: 20).isActive = true
        self.generationLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        self.generationLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        */

        self.layoutIfNeeded()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
