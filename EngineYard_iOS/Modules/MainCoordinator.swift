//
//  MainCoordinator.swift
//  EngineYard
//
//  Created by Amarjit on 20/09/2019.
//  Copyright © 2019 Amarjit. All rights reserved.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = [Coordinator]()
    weak var navigationController: UINavigationController?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = MainMenuViewController.instantiate(ListOfStoryboards.main)
        vc.coordinator = self
        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController?.pushViewController(vc, animated: false)
    }

    func showPlayerSelectScreen() {
        let vc = PlayerSelectScreenViewController.instantiate(ListOfStoryboards.main)
        vc.coordinator = self
        navigationController?.pushViewController(vc, animated: true)
    }

    func showNext() {
        let vc = SecondViewController.instantiate(ListOfStoryboards.main)
        vc.coordinator = self
        navigationController?.pushViewController(vc, animated: true)
    }

    func showWinnerScreen() {
        let vc = WinnerViewController.instantiate(ListOfStoryboards.winner)
        vc.coordinator = self
        navigationController?.pushViewController(vc, animated: true)
    }

    func showListOfCards(position: BoardPosition) {
        /*
        let vc = ListCardsViewController.instantiate()
        vc.coordinator = self
        vc.position = position
        navigationController.pushViewController(vc, animated: true)
         */

        // Run: ListCardsRouter
        let vc = ListCardsRouter.start()
        navigationController?.pushViewController(vc, animated: true)
        
    }
}
