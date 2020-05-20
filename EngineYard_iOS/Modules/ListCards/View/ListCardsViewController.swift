//
//  ListCardsViewController.swift
//  EngineYard
//
//  Created by Amarjit on 20/05/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation
import UIKit

class ListCardsViewController: BaseViewController, StoryboardLoadable {

    // MARK: Properties

    var presenter: ListCardsPresentation?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ListCardsViewController: ListCardsView {
    // TODO: implement view output methods
}
