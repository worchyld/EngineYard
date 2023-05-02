//
//  WinnerView.swift
//  EngineYard
//
//  Created by Amarjit on 02/05/2023.
//

import SwiftUI

struct WinnerView: View {
    let players: [PlayerViewModel]

    var body: some View {
        NavigationView {
                    List {
                        ForEach(players) { player in
                            
                            if (player.cash >= Constants.endGameTriggerCash) {
                                Section(header: Text("Winner \(Constants.endGameTriggerCash)")) {
                                    HStack(alignment: .center, spacing: nil, content: {
                                        Image("trophy")
                                        PlayerHUDHorizontalView(player: player)
                                    })
                                }
                            } else {
                                PlayerHUDHorizontalView(player: player)
                            }
                        }
                    }
                    .navigationBarTitle("End of game")
                    .listStyle(GroupedListStyle())
                }
    }
}

struct WinnerView_Previews: PreviewProvider {
    static var previews: some View {
        WinnerView(players: [
            PlayerViewModel(id: UUID(), avatar: "avt-1", cash: 330, trains: 14, active: true, hand: nil),
                    PlayerViewModel(id: UUID(), avatar: "avt-2", cash: 320, trains: 14, active: false, hand: nil),
                    PlayerViewModel(id: UUID(), avatar: "avt-3", cash: 230, trains: 14, active: false, hand: nil),
                    PlayerViewModel(id: UUID(), avatar: "avt-4", cash: 130, trains: 14, active: false, hand: nil),
                    PlayerViewModel(id: UUID(), avatar: "avt-5", cash: 30, trains: 14, active: false, hand: nil)
                ])
    }
}
