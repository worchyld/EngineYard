//
//  WinnerListItem.swift
//  EngineYard
//
//  Created by Amarjit on 19/11/2020.
//

import SwiftUI

struct WinnerListItem: View {
    let player: Player
    func cashFormat(player: Player) -> String {
        let number: NSNumber = NSNumber(integerLiteral: player.cash)
        let cache = NumberFormatCache.currencyRateFormatter
        return cache.string(from: number) ?? "$0"
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 3.0, content: {
            AvatarView(avatar: player.avatar)
            
            VStack(alignment: .leading, spacing: 5.0, content: {
                
                Text(cashFormat(player: player))
                    .font(.headline)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(.top, 5)

                Text("🚂 \(player.trains)")
                    .font(.caption)
                    .fontWeight(.regular)
                    .multilineTextAlignment(.center)
            }).padding(.leading, 8.0)
            
        })
    }
}

struct WinnerListItem_Previews: PreviewProvider {
    static var previews: some View {
        WinnerListItem( player:
            Player(id: UUID(), avatar: "avt_1", cash: 330, trains: 14, active: true)
        )
    }
}
