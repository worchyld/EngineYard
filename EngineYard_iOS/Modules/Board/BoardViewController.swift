//
//  BoardViewController.swift
//  EngineYard
//
//  Created by Amarjit on 29/05/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import UIKit

class BoardViewController: UIViewController, Storyboarded {
    weak var coordinator: BoardCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Board"
        self.view.backgroundColor = .systemPink
    }

}
