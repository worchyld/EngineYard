//
//  WinnersListViewController.swift
//  EngineYard
//
//  Created by Amarjit on 17/11/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import UIKit

// Displays winner chart

class WinnersViewModel : BaseViewModel {
    static let reuseIdentifier = "winnerCellId"
    static let pageTitle = "Winner"

    override init(game: Game) {
        super.init(game: game)
    }
}

class WinnersListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ConfigureCellDelegate {

    var viewModel: WinnersViewModel!

    lazy var tableView : UITableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.register(UITableViewCell.self, forCellReuseIdentifier: WinnersViewModel.reuseIdentifier)
        tv.allowsMultipleSelection = false
        tv.allowsSelection = false
        return tv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = WinnersViewModel.pageTitle
        self.view.addSubview(tableView)
    }

    // MARK: - Tableview delegate

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let hasGame = self.viewModel.game else {
            return 0
        }
        guard let hasPlayers = hasGame.players else {
            return 0
        }
        return hasPlayers.count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WinnersViewModel.reuseIdentifier, for: indexPath)

        configure(cell: cell, at: indexPath)

        return cell
    }

    @nonobjc func configure(cell: UITableViewCell, at indexPath: IndexPath) {
        guard let hasGame = self.viewModel.game else {
            return
        }
        guard let hasPlayers = hasGame.players else {
            return
        }

        let playerObj = hasPlayers[indexPath.row] as! Player
        let cashText = ObjectCache.currencyRateFormatter.string(from: NSNumber(integerLiteral: playerObj.cash))

        cell.textLabel?.text = "\(String(describing: playerObj.name)), \(cashText ?? "No cash")"
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
