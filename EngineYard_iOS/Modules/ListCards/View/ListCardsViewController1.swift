//
//  ListCardsViewController1.swift
//  EngineYard
//
//  Created by Amarjit on 20/05/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation
import UIKit


//MARK: - View Controller - Initialization
class ListCardsViewController: UIViewController, Storyboarded {

    var presenter: ListCardsViewToPresenterProtocol?

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.red

        presenter?.showCardsList()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


//MARK: - Presenter - delegates
extension ListCardsViewController: ListCardsPresenterToViewProtocol {
    func showCards(cardModel: CardResponseModel) {
        print ("success: \(cardModel)")
    }

    func showError() {
        print("failed")
    }
}
