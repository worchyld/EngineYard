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

    var decks : [Deck] {
        guard let gameObj = self.game else {
            return []
        }
        return gameObj.board.decks
    }
}

class LocomotiveListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var viewModel: LocomotiveListViewModel!

    lazy var tableView : UITableView = {
        let tv = UITableView(frame: self.view.frame, style: .plain)
        tv.delegate = self
        tv.dataSource = self
        //tv.register(UITableViewCell.self, forCellReuseIdentifier: LocomotiveListViewModel.reuseIdentifier)
        tv.register(UINib(nibName: "LocomotiveTableViewCell", bundle: nil), forCellReuseIdentifier: LocomotiveListViewModel.reuseIdentifier)
        tv.allowsSelection = false
        tv.allowsMultipleSelection = false
        return tv
    }()

    @IBOutlet weak var tableContainerView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "\(viewModel.decks.count) decks"
        self.tableContainerView.addSubview(tableView)
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.decks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LocomotiveListViewModel.reuseIdentifier, for: indexPath) as! LocomotiveTableViewCell

        let deck = viewModel.decks[indexPath.row]

        //cell.textLabel?.text = "#\(indexPath.row), \(deck.description)"
        cell.configure(with: deck)

        return cell
    }

}
