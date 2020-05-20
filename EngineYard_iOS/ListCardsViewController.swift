//
//  ListCardsViewController.swift
//  EngineYard
//
//  Created by Amarjit on 19/05/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import UIKit

fileprivate let cellReuseId: String = "ListCards.CellReuseID"

class OldListCardsViewController: UIViewController,
    Storyboarded, UITableViewDelegate, UITableViewDataSource {

    weak var coordinator: MainCoordinator?
    weak var position: BoardPosition? {
        didSet {
            guard let pos = self.position else {
                return
            }
            self.cards = pos.cards
        }
    }
    private var cards: [Card] = [Card]()

    lazy var tableView: UITableView = {
        let tv = UITableView(frame: self.view.frame, style: .plain)
        tv.delegate = self
        tv.dataSource = self
        tv.allowsSelection = false
        tv.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseId)
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Cards"
        self.view.addSubview(self.tableView)
    }

    // --------

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let position = self.position else {
            print ("No position found")
            return 0
        }
        return position.cards.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseId, for: indexPath)

        // Configure the cell...

        guard let position = self.position else {
            return cell
        }
        let card = position.cards[indexPath.row] as Card

        cell.textLabel?.text = card.name

        return cell
    }

    
}
