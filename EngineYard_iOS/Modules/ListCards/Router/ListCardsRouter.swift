//
//  ListCardsRouter.swift
//  EngineYard
//
//  Created by Amarjit on 20/05/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation
import UIKit

class ListCardsRouter {

    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> ListCardsViewController {
        let viewController = UIStoryboard.loadViewController() as ListCardsViewController
        let presenter = ListCardsPresenter()
        let router = ListCardsRouter()
        let interactor = ListCardsInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension ListCardsRouter: ListCardsWireframe {
    // TODO: Implement wireframe methods
}
