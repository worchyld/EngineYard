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
}

class MainMenuCoordinator : Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController?

    func start() {
        handleRoute(.mainMenu)
    }

    func handleRoute(_ route: MainMenuRoute) {
        switch route {
        case .mainMenu:
            let vc = MainMenuViewController.instantiate(StoryboardRef.main)
            vc.coordinator = self
            navigationController?.setNavigationBarHidden(true, animated: false)
            navigationController?.pushViewController(vc, animated: false)
            return

        case .selectPlayer:
            let vc = SelectPlayerViewController.instantiate(StoryboardRef.main)
            vc.coordinator = self
            navigationController?.setNavigationBarHidden(false, animated: true)
            navigationController?.pushViewController(vc, animated: false)
            return
        }
    }
}
