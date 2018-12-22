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

    private lazy var _tableView : UITableView = {
        let tv = UITableView(frame: self.view.frame, style: .plain)
        tv.delegate = self
        tv.dataSource = self
        tv.register(UINib(nibName: "LocomotiveTableViewCell", bundle: nil), forCellReuseIdentifier: LocomotiveListViewModel.reuseIdentifier)
        tv.allowsMultipleSelection = false
        return tv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.automaticallyAdjustsScrollViewInsets = false
        self.title = "\(viewModel.decks.count) decks"

        self.view.addSubview(_tableView)
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
        
        cell.configure(with: deck)

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

}
