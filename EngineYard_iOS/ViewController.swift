//
//  ViewController.swift
//  EngineYard
//
//  Created by Amarjit on 13/04/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import UIKit

/* A quick and dirty output to show in-game decks */

private let reuseIdentifier = "cellId"

private struct ViewModel {
    var game: Game?

    lazy var decks : [Deck] = {
        guard let board = self.game?.board else {
            return []
        }

        return (board.decks)
    }()

    init() {
        let players = Mock.players(howMany: 5)

        guard let gameObj = Game.setup(with: players) else {
            return
        }

        guard let _ = gameObj.board else {
            return
        }

        self.game = gameObj
    }

    mutating func configureCell(cell: UITableViewCell, atIndex: IndexPath) {
        guard ((atIndex.row > 0) && (atIndex.row <= self.decks.count)) else {
            return
        }
        guard let cellLabel = cell.textLabel else {
            return
        }
        let deck = decks[atIndex.row]
        cellLabel.text = "\(deck.name), \(deck.color) \(deck.generation) Cost: $\(deck.cost) Production: $\(deck.productionCost) Income: $\(deck.income)"
    }
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private lazy var tableView: UITableView = {
        let tv = UITableView(frame: self.view.frame, style: UITableViewStyle.plain)
        tv.delegate = self
        tv.dataSource = self
        tv.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        return tv
    }()

    private var viewModel : ViewModel = ViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Trains"
        self.view.addSubview(tableView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.decks.count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)

        // Configure the cell...
        viewModel.configureCell(cell: cell, atIndex: indexPath)

        return cell
    }


}

