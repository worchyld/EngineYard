//
//  PlayersHorizontalListView.swift
//  EngineYard
//
//  Created by Amarjit on 06/11/2020.
//

import SwiftUI

struct PlayersHorizontalListView: View {
    let players: [Player]
    var body: some View {
        HStack(alignment: .firstTextBaseline, spacing: 18, content: {
            PlayerHUDView(player: Player(id: UUID(), avatar: "avt_1", cash: 330, trains: 14, active: true))
            PlayerHUDView(player: Player(id: UUID(), avatar: "avt_2", cash: 330, trains: 14, active: false))
            PlayerHUDView(player: Player(id: UUID(), avatar: "avt_3", cash: 330, trains: 14, active: false))
            PlayerHUDView(player: Player(id: UUID(), avatar: "avt_4", cash: 330, trains: 14, active: false))
            PlayerHUDView(player: Player(id: UUID(), avatar: "avt_5", cash: 330, trains: 14, active: false))
        })
    }
}

struct PlayersHorizontalListView_Previews: PreviewProvider {
    static var previews: some View {
        PlayersHorizontalListView(players: [
            Player(id: UUID(), avatar: "avt_1", cash: 330, trains: 14, active: true),
            Player(id: UUID(), avatar: "avt_2", cash: 330, trains: 14, active: false),
            Player(id: UUID(), avatar: "avt_3", cash: 330, trains: 14, active: false),
            Player(id: UUID(), avatar: "avt_4", cash: 330, trains: 14, active: false),
            Player(id: UUID(), avatar: "avt_5", cash: 330, trains: 14, active: false)
        ])
    }
}