//
//  MainMenuCoordinator.swift
//  EngineYard
//
//  Created by Amarjit on 01/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation
import UIKit

enum MainMenuRoute {
    case mainMenu
    case selectPlayer
    case startGame
}

class MainMenuCoordinator : Coordinator {
    weak var parentCoordinator: MainCoordinator?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        handleRoute(.mainMenu)
    }

    func handleRoute(_ route: MainMenuRoute) {
        switch route {
        case .mainMenu:
            let vc = MainMenuViewController.instantiate(StoryboardRef.main)
            vc.coordinator = self
            navigationController.pushViewController(vc, animated: false)
            return

        case .selectPlayer:
            let vc = SelectPlayerViewController.instantiate(StoryboardRef.main)
            vc.coordinator = self
            navigationController.pushViewController(vc, animated: true)
            return

        case .startGame:
            self.parentCoordinator?.childDidFinish(self)
            self.parentCoordinator?.handleRoute(.play)
            return
        }
    }
    
}
