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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Card view"

        let nib = CardDetailView.nib()
        let customView = nib.instantiate(withOwner: nil, options: nil).first as! UIView

        self.view.addSubview(customView)

        NSLayoutConstraint.activate([
                   customView.topAnchor.constraint(equalTo: self.view.topAnchor),
                   customView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
                   customView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                   customView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
               ])


    }
}
