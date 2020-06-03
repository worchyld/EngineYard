//
//  BoardViewController.swift
//  EngineYard
//
//  Created by Amarjit on 29/05/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import UIKit

struct BoardViewModel {
    let board: Board!

    init(board: Board) {
        self.board = board
    }

    func getPosition(at index: Int) -> BoardPosition {
        return self.board.positions[index]
    }
}

// Show all decks (cards in their position)
class BoardViewController: UIViewController, Storyboarded, ReusableView {
    weak var coordinator: BoardCoordinator?
    var viewModel: BoardViewModel!
    static var reuseIdentifier: String = "BoardViewCellID"

    var cellReuseId: String {
        return BoardViewController.reuseIdentifier
    }

    private lazy var tableView: UITableView = {
        let tv = UITableView(frame: self.view.frame, style: .plain)
        tv.delegate = self
        tv.dataSource = self
        tv.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseId)
        return tv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Decks"
        self.view.addSubview(tableView)

        // : Debug
        print ("Board: \(viewModel.board as Any)")
        self.coordinator?.parentCoordinator?.printCoordinators()
    }

}

// MARK: UITableView delegate methods

extension BoardViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let board = self.viewModel.board else {
            print ("Error -- No board found")
            return 0
        }
        return board.positions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseId, for: indexPath)


        // Configure the cell...
        return configure(cell, at: indexPath)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print ("didSelect: \(indexPath.row)")

        let position = viewModel.getPosition(at: indexPath.row)

        print ("you selected position: \(position.name)")

        coordinator?.showCardList(position: position)
    }
}

extension BoardViewController {
    func configure(_ cell: UITableViewCell, at indexPath: IndexPath) -> UITableViewCell {
        guard let board = self.viewModel.board else {
            return cell
        }

        let position = board.positions[indexPath.row]

        cell.textLabel?.text = position.name
        cell.detailTextLabel?.text = "Cards: \(position.cards.count)"

        return cell
    }

    
}