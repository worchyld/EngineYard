//
//  ListCardsPresenter.swift
//  EngineYard
//
//  Created by Amarjit on 20/05/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

class ListCardsPresenter {

    // MARK: Properties

    weak var view: ListCardsView?
    var router: ListCardsWireframe?
    var interactor: ListCardsUseCase?
}

extension ListCardsPresenter: ListCardsPresentation {
    // TODO: implement presentation methods
}

extension ListCardsPresenter: ListCardsInteractorOutput {
    // TODO: implement interactor output methods
}
