//
//  CardFamiliesViewController.swift
//  EngineYard
//
//  Created by Amarjit on 29/05/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import UIKit

public struct BoardViewModel {
    let board: Board!

    init(board: Board) {
        self.board = board
    }

    func getPosition(at index: Int) -> BoardPosition {
        return self.board.positions[index]
    }
}

// Show all decks/card families
class CardFamiliesViewController: UIViewController, Storyboarded {
    weak var coordinator: BoardCoordinator?
    var viewModel: BoardViewModel!

    var cellReuseIdentifier: String {
        return FamilyTableViewCell.reuseIdentifier
    }

    private lazy var tableView: UITableView = {
        let tv = UITableView(frame: self.view.frame, style: .plain)
        tv.delegate = self
        tv.dataSource = self
        tv.register(FamilyTableViewCell.nib(), forCellReuseIdentifier: FamilyTableViewCell.reuseIdentifier)
        tv.rowHeight = 70
        tv.estimatedRowHeight = 70
        return tv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Decks"
        self.view.addSubview(tableView)
    }

}

// MARK: UITableView delegate methods

extension CardFamiliesViewController : UITableViewDelegate, UITableViewDataSource {
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
        let cell: FamilyTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! FamilyTableViewCell

        // Setup view model for cell
        let position = self.viewModel.board.positions[indexPath.row]
        guard let card = position.cards.first else {
            return cell
        }

        cell.configure(with: card)
        cell.layoutIfNeeded()

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let position = viewModel.getPosition(at: indexPath.row)
        coordinator?.showCardList(position: position)
    }
}
