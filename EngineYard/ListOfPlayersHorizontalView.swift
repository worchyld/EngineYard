//
//  ListOfPlayersHorizontalView.swift
//  EngineYard
//
//  Created by Amarjit on 02/05/2023.
//

import SwiftUI

struct ListOfPlayersHorizontalView: View {
   
    let players: [PlayerViewModel]
    var body: some View {
        HStack(alignment: .firstTextBaseline, spacing: 18, content: {
            ForEach(players) { p in
                PlayerHUDVerticalView(player: p)
            }
            /*
            PlayerHUDVerticalView(player: PlayerViewModel(id: UUID(), avatar: "avt-1", cash: 330, trains: 14, active: true, hand: nil))
            PlayerHUDVerticalView(player: PlayerViewModel(id: UUID(), avatar: "avt-2", cash: 330, trains: 14, active: false))
            PlayerHUDVerticalView(player: PlayerViewModel(id: UUID(), avatar: "avt-3", cash: 330, trains: 14, active: false))
            PlayerHUDVerticalView(player: PlayerViewModel(id: UUID(), avatar: "avt-4", cash: 330, trains: 14, active: false))
            PlayerHUDVerticalView(player: PlayerViewModel(id: UUID(), avatar: "avt-5", cash: 330, trains: 14, active: false))*/
        })
    }

}

struct ListOfPlayersHorizontalView_Previews: PreviewProvider {
    static var previews: some View {
        ListOfPlayersHorizontalView(players: [
                    PlayerViewModel(id: UUID(), avatar: "avt-1", cash: 330, trains: 14, active: true, hand: nil),
                    PlayerViewModel(id: UUID(), avatar: "avt-2", cash: 330, trains: 14, active: false, hand: nil),
                    PlayerViewModel(id: UUID(), avatar: "avt-3", cash: 330, trains: 14, active: false, hand: nil),
                    PlayerViewModel(id: UUID(), avatar: "avt-4", cash: 330, trains: 14, active: false, hand: nil),
                    PlayerViewModel(id: UUID(), avatar: "avt-5", cash: 330, trains: 14, active: false, hand: nil)
                ])
    }
}
