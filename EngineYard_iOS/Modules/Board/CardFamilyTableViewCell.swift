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

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setup()
    }

    lazy var nameLabel: UILabel = {
        let frame = CGRect(x: 0, y: 0, width: 80, height: 14)
        let lbl = UILabel(frame: frame)
        lbl.text = "Name"
        lbl.font = .boldSystemFont(ofSize: 12)
        lbl.sizeToFit()
        return lbl
    }()

    lazy var generationLabel: UILabel = {
        let frame = CGRect(x: 0, y: 20, width: 80, height: 14)
        let lbl = UILabel(frame: frame)
        lbl.text = "Generation"
        lbl.font = .systemFont(ofSize: 10)
        lbl.sizeToFit()
        return lbl
    }()

    
    private func setup() {
        //contentView.addSubview(nameLabel)
        //contentView.addSubview(generationLabel)
        if let image = TrainIcon.black.image {
            let imageView = IconTrainImageView.init(image: image)
            let frame = CGRect(x: 5, y: 5, width: 50, height: 50)
            imageView.frame = frame
            imageView.sizeToFit()
            imageView.clipsToBounds = true
            contentView.addSubview(imageView)
        }

        let frame = CGRect(x: 55, y: 5, width: self.bounds.width - 20, height: 40)
        let stackView = UIStackView(frame: frame)
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 2.0

        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(generationLabel)
        stackView.layoutIfNeeded()

        contentView.addSubview(stackView)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
