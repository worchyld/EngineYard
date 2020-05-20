//
//  SecondViewController.swift
//  EngineYard
//
//  Created by Amarjit on 25/09/2019.
//  Copyright © 2019 Amarjit. All rights reserved.
//

import UIKit

private class CustomCell: UITableViewCell {
    var position: BoardPosition? {
        didSet {

            guard let position = self.position else {
                return
            }
            let name = position.name
            let cardsQty = position.cards.count
            let family = ("\(position.color), \(position.generation)")

            self.textLabel?.text = name
            self.detailTextLabel?.text = "Family: \(family), qty: \(cardsQty)"
            
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SecondViewController: UIViewController,
    UITableViewDataSource, UITableViewDelegate, Storyboarded {

    weak var coordinator: MainCoordinator?

    private var board: Board?
    private static let cellReuseId = "myCellId"

    lazy var tableView : UITableView = {
        let tv = UITableView(frame: self.view.frame, style: .plain)
        tv.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tv.delegate = self
        tv.dataSource = self
        tv.allowsSelection = true
        //tv.register(UITableViewCell.self, forCellReuseIdentifier: SecondViewController.cellReuseId)
        tv.register(CustomCell.self, forCellReuseIdentifier: SecondViewController.cellReuseId)
        return tv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(self.tableView)
        self.title = "Positions"

        self.board = Board.init()
    }


    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let board = self.board else {
            return 1
        }
        return board.positions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: SecondViewController.cellReuseId, for: indexPath) as! CustomCell
        let cell = CustomCell(style: .subtitle, reuseIdentifier: SecondViewController.cellReuseId)

        // Configure the cell...
        cell.accessoryType = .disclosureIndicator

        guard let board = self.board else {
            cell.textLabel?.text = "The board is incorrectly initialized"
            return cell
        }

        let currentItem = board.positions[indexPath.row] as BoardPosition
        cell.position = currentItem

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let board = self.board else {
            return
        }
        let positionAtIndex = board.positions[indexPath.row]
        print ("Selected: \(positionAtIndex.description)")
        coordinator?.showListOfCards(position: positionAtIndex)
    }


}
