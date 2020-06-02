//
//  BoardCoordinator.swift
//  EngineYard
//
//  Created by Amarjit on 01/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation
import UIKit

class BoardCoordinator : Coordinator {
    weak var parentCoordinator: MainCoordinator?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let board = Board()

        let vc = BoardViewController.instantiate(StoryboardRef.board)
        vc.coordinator = self
        vc.viewModel = BoardViewModel.init(board: board)

        navigationController.setNavigationBarHidden(true, animated: true)
        navigationController.pushViewController(vc, animated: true)
    }
}
