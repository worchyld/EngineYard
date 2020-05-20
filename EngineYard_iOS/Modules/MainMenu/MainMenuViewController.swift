//
//  MainMenuViewController.swift
//  EngineYard
//
//  Created by Amarjit on 20/09/2019.
//  Copyright © 2019 Amarjit. All rights reserved.
//

import UIKit
import JGProgressHUD

class MainMenuViewController: UIViewController, Storyboarded {
    weak var coordinator: MainCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    @IBAction func nextBtnPressed(_ sender: Any) {
        #if DEBUG
            self.showPlayerSelectScreen()
        #else
        self.showSimpleHUD()
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1000)) {
            self.showPlayerSelectScreen()
        }
        #endif
    }

    func showPlayerSelectScreen() {
        coordinator?.showPlayerSelectScreen()
    }
}


// SimpleHUD
extension MainMenuViewController {
    func showSimpleHUD() {
        let hud = JGProgressHUD(style: .light)
        hud.vibrancyEnabled = true
        hud.textLabel.text = "Simple example in Swift"
        hud.detailTextLabel.text = "See JGProgressHUD-Tests for more examples"
        hud.shadow = JGProgressHUDShadow(color: .black, offset: .zero, radius: 5.0, opacity: 0.2)
        hud.dismiss(afterDelay: 1.0)
        hud.show(in: self.view)
    }
}
