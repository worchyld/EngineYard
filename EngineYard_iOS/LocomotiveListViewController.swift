//
//  LocomotiveListViewController.swift
//  EngineYard
//
//  Created by Amarjit on 17/11/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import UIKit

// Lists locomotives
// modes: List, ForSale

class LocomotiveListViewModel : BaseViewModel {
    static let pageTitle: String = NSLocalizedString("Buy Train", comment: "Buy train page title")
}

class LocomotiveListViewController: UIViewController {

    var viewModel: LocomotiveListViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = LocomotiveListViewModel.pageTitle

        guard let viewModel = self.viewModel else {
            return
        }
        print(viewModel.description)
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
