//
//  NewGameSetupViewController.swift
//  EngineYard
//
//  Created by Amarjit on 05/10/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import UIKit

class DummyPlayer {
    var name: String
    var isAI: Bool = false
    var asset: String?
    var isActive: Bool = false

    init(name: String, isAI: Bool = false, asset: String? = nil, isActive: Bool = false) {
        self.name = name
        self.isAI = isAI
        if let asset = asset {
            self.asset = asset
        }
        self.isActive = isActive
    }
}

private struct NewGameViewModel {
    static let pageTitle = "New game setup"
    static let reuseIdentifier = "PlayerCellID"
    static let segue = "LaunchGameSegue"

    var dummyPlayers: [DummyPlayer] = [DummyPlayer]()
    var maxPlayers: Int = Rules.NumberOfPlayers.max
    var game: Game?

    init() {
        for idx:Int in 1...maxPlayers {
            let name = "Player #\(idx)"
            let filename = "avt_\(idx)"

            var isActive: Bool = false
            var isAI: Bool = true
            if (idx == 1) {
                isAI = false
                isActive = true
            }

            let playerObj = DummyPlayer.init(name: name, isAI: isAI, asset: filename, isActive: isActive)
            self.dummyPlayers.append(playerObj)
        }
    }

    mutating func launchGame() {
        var players: [Player] = [Player]()

        self.dummyPlayers.forEach { (p: DummyPlayer) in
            let playerObj = Player(name: p.name, isAI: p.isAI, asset: p.asset)
            players.append(playerObj)
        }

        guard let gameObj = Game.setup(with: players) else {
            assertionFailure("Invalid game object")
            return
        }
        guard let _ = gameObj.board else {
            assertionFailure("Invalid game board")
            return
        }
        self.game = gameObj
        print (self.game?.description as Any)
    }
}


class NewGameSetupViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, ConfigureCellDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var btnPlay: UIButton!
    
    private var viewModel: NewGameViewModel = NewGameViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = false
        self.title = NewGameViewModel.pageTitle
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName:"NewGamePlayerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: NewGameViewModel.reuseIdentifier)
        self.collectionView.allowsMultipleSelection = false
        self.collectionView.layoutIfNeeded()

        let barBtnPlay = UIBarButtonItem.init(title: "Play", style: .done, target: self, action: #selector(playBtnDidPress))
        self.navigationItem.rightBarButtonItem = barBtnPlay
    }

    // MARK: - CollectionView

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.dummyPlayers.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell: NewGamePlayerCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: NewGameViewModel.reuseIdentifier, for: indexPath) as! NewGamePlayerCollectionViewCell

        configure(cell: cell, at: indexPath)

        return cell
    }

    @nonobjc func configure(cell: NewGamePlayerCollectionViewCell, at indexPath: IndexPath) {
        cell.player = viewModel.dummyPlayers[indexPath.row]
    }

    // MARK: - Actions

    @objc func playBtnDidPress() {
        submitPlayBtn()
    }

    @IBAction func playDidPress() {
        submitPlayBtn()
    }

    private func submitPlayBtn() {
        viewModel.launchGame()

        waitFor(duration: 0.85) { (completed) in
            if (completed) {
                self.performSegue(withIdentifier: NewGameViewModel.segue, sender: self)
            }
        }
    }

    // MARK: - Navigation

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if (identifier == NewGameViewModel.segue) {
            guard let hasGame = self.viewModel.game else {
                print ("No game")
                return false
            }
            guard let _ = hasGame.board else {
                print ("No board")
                return false
            }
            guard (viewModel.dummyPlayers.count >= Rules.NumberOfPlayers.min && viewModel.dummyPlayers.count <= Rules.NumberOfPlayers.max) else {
                print ("Not enough players")
                return false
            }
        }
        return true
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.

        if (segue.identifier == NewGameViewModel.segue) {
            guard let hasGame = self.viewModel.game else {
                print ("No game")
                return 
            }
            let vc : LocomotiveListViewController = (segue.destination as? LocomotiveListViewController)!
            vc.viewModel = LocomotiveListViewModel.init(game: hasGame)

        }

    }


}
