//
//  HUDViewController.swift
//  EngineYard
//
//  Created by Amarjit on 27/11/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import UIKit

class HUDViewModel : BaseViewModel {
    static let reuseIdentifier = "HUDReusableCellId"
}

class HUDViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var viewModel: HUDViewModel?

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var phaseTextLabel: UILabel!
    @IBOutlet weak var helperTextLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: HUDViewModel.reuseIdentifier)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.backgroundColor = UIColor.clear
        self.collectionView.allowsMultipleSelection = false
        self.collectionView.layoutIfNeeded()
    }

    // MARK: UICollectionView Delegate

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.game?.players?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell: UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: HUDViewModel.reuseIdentifier, for: indexPath) //as! UICollectionViewCell

        let playerObj: Player = viewModel?.game?.players?[indexPath.row] as! Player

        let arr = UINib(nibName: "PlayerHUDView", bundle: nil).instantiate(withOwner: nil, options: nil)
        let view = arr[0] as! PlayerHUDView
        cell.contentView.addSubview(view)
        view.configure(with: playerObj)

        view.updateConstraints()
        view.layoutIfNeeded()

        return cell
    }
}
