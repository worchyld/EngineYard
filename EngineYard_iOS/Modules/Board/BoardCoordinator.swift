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
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController?

    func start() {
        let vc = BoardViewController.instantiate(StoryboardRef.board)
        vc.coordinator = self
        navigationController?.setNavigationBarHidden(true, animated: true)
        navigationController?.pushViewController(vc, animated: false)
    }
}