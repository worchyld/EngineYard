//
//  PlayerWalletInterface.swift
//  EngineYard
//
//  Created by Amarjit on 14/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

// The interface between a player's cash var and the
// wallet proxy which handles credit/debit rules

class PlayerWalletInterface {
    private let player: Player
    private let wallet: Wallet

    init(player: Player) {
        self.player = player
        self.wallet = Wallet.init(player.cash)
    }
}

extension PlayerWalletInterface : CreditDelegate {
    func credit(_ amount: Int) throws -> Int? {
        do {
            if let balance = try self.wallet.credit(amount) {
                self.handleCredit(balance)
                return player.cash
            }
            else {
                throw WalletError.undefinedWallet
            }
        } catch {
            throw error
        }
    }

    internal func handleCredit(_ amount: Int) {
        player.setCash(amount)
    }
}


extension PlayerWalletInterface : DebitDelegate {
    func debit(_ amount: Int) throws -> Int? {
        do {
            if let balance = try self.wallet.debit(amount) {
                self.handleDebit(balance)
                return player.cash
            }
            else {
                throw WalletError.undefinedWallet
            }
        } catch {
            throw error
        }
    }

    internal func handleDebit(_ amount: Int) {
        player.setCash(amount)
    }
}
