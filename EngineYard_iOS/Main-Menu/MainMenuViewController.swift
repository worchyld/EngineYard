//
//  MainMenuViewController.swift
//  EngineYard
//
//  Created by Amarjit on 05/10/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import UIKit

private struct ViewModel {    
    struct Segue {
        static let newGameSegue : String = "newGameSegue"
    }
}

class MainMenuViewController: UIViewController {

    @IBOutlet weak var playBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        UIView.animate(withDuration: 0.25) {
            self.navigationController?.isNavigationBarHidden = true
        }
    }
    
    @IBAction func playBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: ViewModel.Segue.newGameSegue, sender: self)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
