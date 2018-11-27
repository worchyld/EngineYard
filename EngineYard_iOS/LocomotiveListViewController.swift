//
//  LocomotiveListViewController.swift
//  EngineYard
//
//  Created by Amarjit on 18/11/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import UIKit

// Lists locomotives
// modes: List, ForSale

class LocomotiveListViewModel : BaseViewModel {
    static let pageTitle: String = NSLocalizedString("Buy Train", comment: "Buy train page title")
    static let reuseIdentifier = "LocomotiveCellId"
}

class LocomotiveListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var viewModel: LocomotiveListViewModel?

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: LocomotiveListViewModel.reuseIdentifier)
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = self.viewModel else {
            return 0
        }
        guard let gameObj = viewModel.game else {
            return 0
        }
        return gameObj.board.decks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LocomotiveListViewModel.reuseIdentifier, for: indexPath)

        // Configure the cell...
        configure(cell: cell, at: indexPath)

        return cell
    }

    func configure(cell: UITableViewCell, at indexPath: IndexPath) {
        guard let viewModel = self.viewModel else {
            return
        }
        guard let gameObj = viewModel.game else {
            return
        }
        guard (indexPath.row > 0 && indexPath.row <= gameObj.board.decks.count) else {
            return
        }
        guard let cellLabel = cell.textLabel else {
            return
        }

        let deck = gameObj.board.decks[indexPath.row]
        cellLabel.text = "\(deck.name), \(deck.color) \(deck.generation) Cost: $\(deck.cost) Production: $\(deck.productionCost) Income: $\(deck.income)"
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
