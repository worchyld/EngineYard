//
//  CardDetailViewController.swift
//  EngineYard
//
//  Created by Amarjit on 22/12/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import UIKit

class CardDetailViewModel : BaseViewModel {
    var deck: Deck!    
}

class CardDetailViewController: UIViewController {

    var viewModel : CardDetailViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = viewModel.deck.name

        print ("Viewing: \(viewModel.deck.description)")
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
