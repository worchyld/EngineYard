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
class CardDetailViewController: UIViewController, NibViewController, Storyboarded {
    typealias ViewType = CardView

    weak var coordinator: BoardCoordinator?
    var viewModel: CardViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Card view"
    }
}
