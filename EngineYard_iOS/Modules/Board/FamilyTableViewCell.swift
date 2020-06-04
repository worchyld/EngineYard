//
//  FamilyTableViewCell.swift
//  EngineYard
//
//  Created by Amarjit on 04/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import UIKit

class FamilyTableViewCell: UITableViewCell {
    @IBOutlet weak var iconTrainImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var generationLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    //@IBOutlet weak var productionLabel: UILabel!
    //@IBOutlet weak var incomeLabel: UILabel!

    static var reuseIdentifier: String = "FamilyCellID"
    static func nib() -> UINib {
        return UINib(nibName: "FamilyTableViewCell", bundle: Bundle.main)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    struct FamilyViewModel {
        private (set) var name: String
        private (set) var cost: Int
        private (set) var generation: Family.Generation

        init(name: String, cost: Int, generation: Family.Generation) {
            self.name = name
            self.cost = cost
            self.generation = generation
        }

        public lazy var formattedCost: String = {
            let number: NSNumber = NSNumber(value: self.cost)
            let cache = NumberFormatCache.currencyRateFormatter
            return cache.string(from: number) ?? "NaN"
        }()
    }


    func configure(with position: BoardPosition) {
        var viewModel = FamilyViewModel.init(name: position.name,
                                             cost: position.cost,
                                             generation: position.generation)

        let bgColor = UIColor.flat(color: position.color.flatColor)
        self.backgroundColor = bgColor
        
        self.nameLabel?.text = viewModel.name
        self.generationLabel?.text = String(describing: viewModel.generation).capitalizingFirstLetter()
        self.costLabel?.text = viewModel.formattedCost

        self.nameLabel?.sizeToFit()
        self.generationLabel?.sizeToFit()
        self.costLabel?.sizeToFit()
    }

    // Not used
    private func configure(with name: String, generation: Family.Generation, cost: Int) {
        var viewModel = FamilyViewModel.init(name: name, cost: cost, generation: generation)

        self.nameLabel?.text = viewModel.name
        self.generationLabel?.text = String(describing: viewModel.generation).capitalizingFirstLetter()
        self.costLabel?.text = viewModel.formattedCost

        self.nameLabel?.sizeToFit()
        self.generationLabel?.sizeToFit()
        self.costLabel?.sizeToFit()
    }
}
