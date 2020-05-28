//
//  MainMenuCoordinator.swift
//  EngineYard
//
//  Created by Amarjit on 28/05/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation
import UIKit

class MainMenuCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = [Coordinator]()
    weak var navigationController: UINavigationController?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = MainMenuViewController.instantiate(ListOfStoryboards.main)
        vc.coordinator = self
        navigationController?.pushViewController(vc, animated: false)
    }

    func showPlayerSelectScreen() {
        let vc = PlayerSelectScreenViewController.instantiate(ListOfStoryboards.main)
        vc.coordinator = self
        navigationController?.pushViewController(vc, animated: true)
    }
}
