//
//  ListCardsRouter.swift
//  EngineYard
//
//  Created by Amarjit on 20/05/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation
import UIKit

class ListCardsRouter: ListCardsPresenterToRouterProtocol {
    weak var coordinator: MainCoordinator? // would like in a protocol

    static func start() -> UIViewController {
        print ("IN: ListCardsRouter")

        let view = ListCardsViewController.instantiate()
        let presenter: ListCardsViewToPresenterProtocol & ListCardsInteractorToPresenterProtocol = ListCardsPresenter()
        let interactor: ListCardsPresentorToInteractorProtocol = ListCardsInteractor()
        let router: ListCardsPresenterToRouterProtocol = ListCardsRouter()

        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter

        return view
    }
}
