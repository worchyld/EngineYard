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
        let child = MainMenuCoordinator(navigationController: navigationController)
        child.parentCoordinator = self
        childCoordinators.append(child)
        child.start()
    }

    func showBoard() {
        let child = BoardCoordinator(navigationController: navigationController)
        child.parentCoordinator = self
        childCoordinators.append(child)
        child.start()
    }

    func childDidFinish(_ child: Coordinator?) {
        print ("childDidFinish")
        for (index, element) in childCoordinators.enumerated() {
            if element === child {
                childCoordinators.remove(at: index)
                break
            }
        }

        for (index, element) in childCoordinators.enumerated() {
            print ("index: \(index), \(element as Any)")
        }
    }

}
