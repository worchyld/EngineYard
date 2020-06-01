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

    func childDidFinish() {
        print ("childDidFinish")
    }

}
