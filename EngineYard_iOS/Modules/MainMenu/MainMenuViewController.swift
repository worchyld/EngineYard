//
//  MainMenuViewController.swift
//  EngineYard
//
//  Created by Amarjit on 20/09/2019.
//  Copyright © 2019 Amarjit. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController, Storyboarded {
    weak var coordinator: MainMenuCoordinator?

    @IBOutlet weak var imageViewIcon: UIImageView!
    @IBOutlet weak var labelHeadline: UILabel!
    @IBOutlet var borderedButtonCollection: [BorderedButton]!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func handleButtonPress(_ sender: UIButton) {
        let tag = sender.tag
        print ("Tag: \(tag) pressed")

        self.coordinator?.handleRoute(.selectPlayer)
    }

}


// SimpleHUD -- #TODO
extension MainMenuViewController {
    func showPlayerSelectScreen() {
    }
}
