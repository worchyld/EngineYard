//
//  ListCardsViewController1.swift
//  EngineYard
//
//  Created by Amarjit on 20/05/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation
import UIKit


//MARK: - View Controller - Initialization
class ListCardsViewController: UIViewController, Storyboarded {
    var presenter: ListCardsViewToPresenterProtocol?

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureView()

        presenter?.showCardsList()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // My view/tableview setup
    private var model: CardResponseModel? {
        didSet {
            print ("did set model")
        }
    }

    lazy var cellReuseId = String(describing: ListCardsViewController.self) + ".cell"
    lazy var tableView: UITableView = {
        let tv = UITableView(frame: self.view.frame, style: .plain)
        tv.delegate = self
        tv.dataSource = self
        tv.allowsSelection = false
        tv.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseId)
        return tv
    }()
}


//MARK: - Presenter - delegates
extension ListCardsViewController: ListCardsPresenterToViewProtocol {
    func showCards(cardModel: CardResponseModel) {
        print ("success: \(cardModel)")
        self.model = cardModel
        self.tableView.reloadData()
    }

    func showError() {
        print("failed")
    }
}

// Setup my view
extension ListCardsViewController {
    func configureView() {
        self.title = "Cards"
        self.view.backgroundColor = UIColor.blue
        self.view.addSubview(self.tableView)
    }
}


// :UITableView delegate extension

extension ListCardsViewController: UITableViewDelegate, UITableViewDataSource {

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
       return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let hasModel = self.model else {
            return 0
        }
        return hasModel.cards.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseId, for: indexPath)

       // Configure the cell...
        return configureCell(cell: cell, at: indexPath)
    }
}

extension ListCardsViewController {
    func configureCell(cell: UITableViewCell, at indexPath: IndexPath) -> UITableViewCell {
        guard let hasModel = self.model else {
            return cell
        }
        let card = hasModel.cards[indexPath.row]

        cell.textLabel?.text = card.description

        return cell
    }
}
