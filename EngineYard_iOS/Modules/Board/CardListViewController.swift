//
//  CardListViewController.swift
//  EngineYard
//
//  Created by Amarjit on 03/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation
import UIKit

// Listing cards within a group/family
class CardListViewController: UIViewController, Storyboarded, ReusableView {
    weak var coordinator: BoardCoordinator?
    static var reuseIdentifier: String = "CardListCell"

    var cellReuseId: String {
        return CardListViewController.reuseIdentifier
    }

    var viewModel: CardListViewModel!

    private lazy var tableView: UITableView = {
        let tv = UITableView(frame: self.view.frame, style: .plain)
        tv.delegate = self
        tv.dataSource = self
        tv.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseId)
        return tv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.viewModel.pageTitle
        self.view.addSubview(self.tableView)
    }

}

// MARK: UITableView delegate methods

extension CardListViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.cards.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseId, for: indexPath)

        let card = self.viewModel.cards[indexPath.row]

        cell.textLabel?.text = ("\(card.name), $\(card.cost), \(card.color), \(card.generation)")

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print ("didSelect: \(indexPath.row)")

        let card = viewModel.cards[indexPath.row]
        self.coordinator?.showSingleCard(card)
    }
}
