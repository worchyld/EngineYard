//
//  PlayerAvatarView.swift
//  EngineYard
//
//  Created by Amarjit on 06/11/2020.
//

import SwiftUI

struct PlayerHUDView: View {
    let player: Player
    func cashFormat(player: Player) -> String {
        let number: NSNumber = NSNumber(integerLiteral: player.cash)
        let cache = NumberFormatCache.currencyRateFormatter
        return cache.string(from: number) ?? "$0"
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8.0) {
            AvatarView(avatar: player.avatar)
                .overlay(
                    RoundedRectangle(cornerRadius: 8.0)
                        .stroke(Color.blue, lineWidth: 2)
                )
            
            VStack(alignment: .leading, spacing: 5, content: {
                Text(cashFormat(player: player))
                    .font(.caption)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)

                Text("🚂 \(player.trains)")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
            })
        }
    }
}

struct PlayerAvatarView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerHUDView(player: Player(avatar: "avt_1", cash: 330, trains: 14))
    }
}
