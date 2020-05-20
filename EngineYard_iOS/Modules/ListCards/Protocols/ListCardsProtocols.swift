//
//  ListCardsProtocols.swift
//  EngineYard
//
//  Created by Amarjit on 20/05/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation
import UIKit

/*
protocol ListCardsPresenterToViewProtocol: class {
    func showListCards(cardModel: CardResponseModel)
    func showError()
}

protocol ListCardsInteractorToPresenterProtocol: class {
    func cardListFeed(cardModel: CardResponseModel)
    func cardListFetchedFailed()
}

protocol ListCardsPresentorToInteractorProtocol: class {
    var presenter: ListCardsInteractorToPresenterProtocol? {get set}
    func fetchCardList()
}*/

protocol ListCardsPresenterToViewProtocol: class {
    func showCards(cardModel: CardResponseModel)
    func showError()
}

protocol ListCardsInteractorToPresenterProtocol: class {
    func employeeListFeed(cardModel: CardResponseModel)
    func employeeListFetchedFailed()
}

protocol ListCardsPresentorToInteractorProtocol: class {
    var presenter: ListCardsInteractorToPresenterProtocol? {get set}
    func fetchCardList()
}

// -----

protocol ListCardsViewToPresenterProtocol: class {
    var view: ListCardsPresenterToViewProtocol? {get set}
    var interactor: ListCardsPresentorToInteractorProtocol? {get set}
    var router: ListCardsPresenterToRouterProtocol? {get set}
    func showCardsList()
}

protocol ListCardsPresenterToRouterProtocol: class {
    static func start() -> UIViewController
}
