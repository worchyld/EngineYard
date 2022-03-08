//
//  PlayersHorizontalListView.swift
//  EngineYard
//
//  Created by Amarjit on 06/11/2020.
//

import SwiftUI

struct ListOfPlayersHorizontalView: View {
    let players: [PlayerViewModel]
    var body: some View {
        HStack(alignment: .firstTextBaseline, spacing: 18, content: {
            PlayerHUDVerticalView(player: PlayerViewModel(id: UUID(), avatar: "avt-1", cash: 330, trains: 14, active: true))
            PlayerHUDVerticalView(player: PlayerViewModel(id: UUID(), avatar: "avt-2", cash: 330, trains: 14, active: false))
            PlayerHUDVerticalView(player: PlayerViewModel(id: UUID(), avatar: "avt-3", cash: 330, trains: 14, active: false))
            PlayerHUDVerticalView(player: PlayerViewModel(id: UUID(), avatar: "avt-4", cash: 330, trains: 14, active: false))
            PlayerHUDVerticalView(player: PlayerViewModel(id: UUID(), avatar: "avt-5", cash: 330, trains: 14, active: false))
        })
    }
}

struct PlayersHorizontalListView_Previews: PreviewProvider {
    static var previews: some View {
        ListOfPlayersHorizontalView(players: [
            PlayerViewModel(id: UUID(), avatar: "avt-1", cash: 330, trains: 14, active: true),
            PlayerViewModel(id: UUID(), avatar: "avt-2", cash: 330, trains: 14, active: false),
            PlayerViewModel(id: UUID(), avatar: "avt-3", cash: 330, trains: 14, active: false),
            PlayerViewModel(id: UUID(), avatar: "avt-4", cash: 330, trains: 14, active: false),
            PlayerViewModel(id: UUID(), avatar: "avt-5", cash: 330, trains: 14, active: false)
        ])
    }
}
