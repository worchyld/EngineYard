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
class CardListViewController: UIViewController, Storyboarded {
    weak var coordinator: BoardCoordinator?

    var cellReuseIdentifier: String {
        return FamilyTableViewCell.reuseIdentifier
    }

    var viewModel: CardListViewModel!

    private lazy var tableView: UITableView = {
        let tv = UITableView(frame: self.view.frame, style: .plain)
        tv.delegate = self
        tv.dataSource = self
        //tv.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tv.register(FamilyTableViewCell.nib(), forCellReuseIdentifier: FamilyTableViewCell.reuseIdentifier)
        tv.rowHeight = 70 //UITableView.automaticDimension
        tv.estimatedRowHeight = 70
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
        //let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        let cell: FamilyTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! FamilyTableViewCell

        let card = self.viewModel.cards[indexPath.row]
        print ("\(card.name), $\(card.cost), \(card.color), \(card.generation)")

        cell.configure(with: card)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print ("didSelect: \(indexPath.row)")

        let card = viewModel.cards[indexPath.row]
        self.coordinator?.showSingleCard(card)
    }
}
