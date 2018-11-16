//
//  NewGameSetupViewController.swift
//  EngineYard
//
//  Created by Amarjit on 05/10/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import UIKit

private struct ViewModel {
    static let pageTitle = "New game setup"
    static let reuseIdentifier = "PlayerCellID"

    var players: [Player] = [Player]()

    init() {
        for idx:Int in 1...Rules.NumberOfPlayers.max {
            let name = "Player #\(idx)"
            let filename = "avt_\(idx)"

            var isAI: Bool = true
            if (idx == 1) {
                isAI = false
            }

            let playerObj = Player.init(name: name, isAI: isAI, asset: filename)
            self.players.append(playerObj)
        }
    }
}


class NewGameSetupViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, ConfigureCellDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    private var viewModel: ViewModel = ViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = false
        self.title = ViewModel.pageTitle
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName:"NewGamePlayerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: ViewModel.reuseIdentifier)
        self.collectionView.allowsMultipleSelection = false
        self.collectionView.layoutIfNeeded()
    }

    // MARK: - CollectionView

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.players.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        //let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ViewModel.reuseIdentifier, for: indexPath)
        let cell: NewGamePlayerCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: ViewModel.reuseIdentifier, for: indexPath) as! NewGamePlayerCollectionViewCell

        configure(cell: cell, at: indexPath)

        return cell
    }

    @nonobjc func configure(cell: NewGamePlayerCollectionViewCell, at indexPath: IndexPath) {
        cell.player = viewModel.players[indexPath.row]
    }



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
