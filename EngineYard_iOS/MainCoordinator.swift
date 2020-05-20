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
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = MainMenuViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }

    func showNext() {
        let vc = SecondViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
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
        navigationController.pushViewController(vc, animated: true)
        
    }
}
