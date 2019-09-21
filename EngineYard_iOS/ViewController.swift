//
//  ViewController.swift
//  EngineYard
//
//  Created by Amarjit on 20/09/2019.
//  Copyright © 2019 Amarjit. All rights reserved.
//

import UIKit

class ViewController: UIViewController, Storyboarded {
    weak var coordinator: MainCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func buyBtnPressed(_ sender: Any) {
        //coordinator?.buySubscription()
    }

    @IBAction func createBtnPressed(_ sender: Any) {
        //coordinator?.createAccount()
    }
}
