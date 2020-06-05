//
//  BoardCoordinator.swift
//  EngineYard
//
//  Created by Amarjit on 01/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation
import UIKit

public class Game {
    var board: Board?

    init(board: Board) {
        self.board = board
    }
}

class BoardCoordinator : Coordinator {
    weak var parentCoordinator: MainCoordinator?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var game: Game?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let board = Board()
        self.game = Game.init(board: board)

        // Show all card families
        let vc = CardFamiliesViewController.instantiate(StoryboardRef.board)
        vc.coordinator = self
        vc.viewModel = BoardViewModel.init(board: board)

        navigationController.setNavigationBarHidden(false, animated: true)
        navigationController.pushViewController(vc, animated: true)
    }

    func showCardList(position: BoardPosition) {
        guard let hasGame = self.game else {
            return
        }
        guard let _ = hasGame.board else {
            return
        }

        let vc = CardListViewController.instantiate(StoryboardRef.board)
        vc.coordinator = self
        vc.viewModel = CardListViewModel.init(position: position)

        navigationController.pushViewController(vc, animated: true)
    }

    func showSingleCard(_ card: Card) {
        let vc = CardDetailViewController.instantiate(StoryboardRef.board)
        vc.coordinator = self
        vc.viewModel = CardViewModel.init(card: card)

        navigationController.pushViewController(vc, animated: true)
    }
}
