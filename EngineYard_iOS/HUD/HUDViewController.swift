//
//  HUDViewController.swift
//  EngineYard
//
//  Created by Amarjit on 22/12/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import UIKit

class HUDViewModel : BaseViewModel {
    static let reuseIdentifier = "HUDCellId"
}

class HUDViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var viewModel: HUDViewModel!
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK - CollectionView

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let game = self.viewModel.game else {
            return 0
        }
        return game.players?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HUDViewModel.reuseIdentifier, for: indexPath)

        configure(cell: cell, at: indexPath)

        return cell
    }
}

extension HUDViewController : ConfigureCellDelegate {

    @nonobjc func configure(cell: UICollectionViewCell, at indexPath: IndexPath) {
        if let game = self.viewModel.game {

            let players = game.players as! [Player]
            let playerObj = players[indexPath.row]

            let arr = UINib(nibName: "PlayerHUDView", bundle: nil).instantiate(withOwner: nil, options: nil)
            let view = arr[0] as! PlayerHUDView
            cell.contentView.addSubview(view)

            view.configure(with: playerObj)
            view.updateConstraints()
            view.layoutIfNeeded()
        }
    }

}
