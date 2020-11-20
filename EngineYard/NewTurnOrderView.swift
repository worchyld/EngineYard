//
//  NewTurnOrderView.swift
//  EngineYard
//
//  Created by Amarjit on 20/11/2020.
//

import SwiftUI

struct NewTurnOrderView: View {
    let players: [Player]
    var body: some View {
        NavigationView {
            List {
                ForEach(players) { player in
                    HStack(alignment: .center, spacing: 15) {
                        Text("#1")
                        PlayerHUDHorizontalView(player: player)
                    }
                }
            }
            .navigationBarTitle("New Turn Order")
        }
    }
}

struct NewTurnOrderView_Previews: PreviewProvider {
    static var previews: some View {
        NewTurnOrderView(players: [Player(id: UUID(), avatar: "avt-1", cash: 330, trains: 14, active: true),
                         Player(id: UUID(), avatar: "avt-2", cash: 320, trains: 14, active: false),
                         Player(id: UUID(), avatar: "avt-3", cash: 230, trains: 14, active: false),
                         Player(id: UUID(), avatar: "avt-4", cash: 130, trains: 14, active: false),
                         Player(id: UUID(), avatar: "avt-5", cash: 30, trains: 14, active: false)
        ])
    }
}
