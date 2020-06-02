//
//  MainCoordinator.swift
//  EngineYard
//
//  Created by Amarjit on 20/09/2019.
//  Copyright © 2019 Amarjit. All rights reserved.
//

import Foundation
import UIKit

enum MainRoute {
    case root
    case play
}

class MainCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {
    var childCoordinators: [Coordinator] = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        navigationController.delegate = self
        handleRoute(.root)
    }

    func handleRoute(_ route: MainRoute) {
        switch route {
        case .root:
            let child = MainMenuCoordinator(navigationController: navigationController)
            child.parentCoordinator = self
            childCoordinators.append(child)
            child.start()
            return

        case .play:
            let child = BoardCoordinator(navigationController: navigationController)
            child.parentCoordinator = self
            childCoordinators.append(child)
            child.start()
            return
        }
    }

    func childDidFinish(_ child: Coordinator?) {
        print ("childDidFinish")

        print ("\nPre")
        printCoordinators()

        for (index, element) in childCoordinators.enumerated() {
            if element === child {
                childCoordinators.remove(at: index)
                break
            }
        }

        print ("\nPost")
        printCoordinators()

    }

    func navigationController(_ navigationController: UINavigationController,
                              didShow viewController: UIViewController, animated: Bool) {

        // Get the from VC
        guard let fromVC = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }

        // check if it contains it
        if navigationController.viewControllers.contains( fromVC ) {
            return
        }

//        if let vc = fromVC as? SelectPlayerViewController {
//            childDidFinish(vc.coordinator)
//        }
    }

}

extension MainCoordinator  {
    func printCoordinators() {
        print ("\nchildCoordinators: \(childCoordinators.count)")
        for (index, element) in childCoordinators.enumerated() {
            print ("... index: \(index), \(element as Any)")
        }
    }
}
