//
//  WinnerViewController.swift
//  EngineYard
//
//  Created by Amarjit on 20/05/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import UIKit

private struct DummyPlayerViewModel: PlayerProtocol, Identifiable {
    let id: UUID = UUID()
    let name: String
    let cash: Int
    let avatar: String
    var playerId: Int = 0
    var state: Player.State = .none
    var hand: Hand = Hand() // empty hand

    init(name: String, cash: Int = 0, avatar: String = "avt_1") {
        self.name = name
        self.cash = cash
        self.avatar = avatar
    }
}

extension DummyPlayerViewModel {
    public static func createDummyPlayers() -> [DummyPlayerViewModel] {
        var players: [DummyPlayerViewModel] = [
               DummyPlayerViewModel.init(name: "Alex", cash: 330, avatar: "avt_1"),
               DummyPlayerViewModel.init(name: "Sarah", cash: 100, avatar: "avt_2"),
               DummyPlayerViewModel.init(name: "Yanus", cash: 99, avatar: "avt_3"),
               DummyPlayerViewModel.init(name: "Ted", cash: 329, avatar: "avt_4"),
               DummyPlayerViewModel.init(name: "Moa", cash: 1, avatar: "avt_5")
           ]

        // Sort by highest cash
        players = players.sorted(by: {
                       (a: DummyPlayerViewModel, b: DummyPlayerViewModel) -> Bool in
                   return (a.cash > b.cash)
               })

        return players
    }
}

// Shows a winner from a collection of dummy players in a tableview

class WinnerViewController: UIViewController, Storyboarded {
    weak var coordinator: MainCoordinator?

    private lazy var cellReuseId = self.theClassName + ".cell"
    private var players = DummyPlayerViewModel.createDummyPlayers()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Winner page"
    }
}


// :UITableView delegate extension

extension WinnerViewController: UITableViewDelegate, UITableViewDataSource {

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
       return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.players.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseId, for: indexPath)

       // Configure the cell...
        return configureCell(cell: cell, at: indexPath)
    }

    func configureCell(cell: UITableViewCell, at indexPath: IndexPath) -> UITableViewCell {



        return cell
    }
}
