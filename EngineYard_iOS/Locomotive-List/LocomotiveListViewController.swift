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

    weak var selectedDeck: Deck?
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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = false
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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let deck = viewModel.decks[indexPath.row]

        if (!deck.active) {

        }
        else {
            self.viewModel.selectedDeck = deck
            performSegue(withIdentifier: "cardDetailSegue", sender: self)
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

    // MARK: - Segue handling

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        guard let selectedDeck = self.viewModel.selectedDeck else {
            return false
        }
        guard let _ = self.viewModel.game else {
            return false
        }
        if (!selectedDeck.active) {
            let message = Message(title: "Train is not available", message: "This train is not available for purchase. Please buy an earlier model.")
            self.showAlert(message: message)
            return false
        }
        if (selectedDeck.rustedState == .obsolete) {
            let message = Message(title: "Train is obsolete", message: "Cannot buy/view an obsolete train")
            self.showAlert(message: message)
            return false
        }
        return (identifier == "cardDetailSegue")
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let game = self.viewModel.game else {
            return
        }
        guard let selectedDeck = self.viewModel.selectedDeck else {
            return
        }
        if (segue.identifier == "cardDetailSegue") {
            print ("You selected on: \(selectedDeck.name)")
            let vc : CardDetailViewController = (segue.destination as? CardDetailViewController)!
            vc.viewModel = CardDetailViewModel.init(game: game)
            vc.viewModel.deck = selectedDeck
        }
    }

}
