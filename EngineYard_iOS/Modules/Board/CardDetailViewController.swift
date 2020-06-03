//
//  CardDetailViewController.swift
//  EngineYard
//
//  Created by Amarjit on 03/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation
import UIKit

// Show a single card
class CardDetailViewController: UIViewController, Storyboarded {
    weak var coordinator: BoardCoordinator?
    var viewModel: CardViewModel!
    private weak var cardView: CardView?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Card view"

        let customView = CardView().loadNib() as! CardView
        customView.frame = self.view.frame
        view.addSubview(customView)
    }
}
