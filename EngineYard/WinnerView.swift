//
//  WinnerView.swift
//  EngineYard
//
//  Created by Amarjit on 06/11/2020.
//

import SwiftUI

struct WinnerView: View {
    let players: [Player]
    var body: some View {
        List {
            Text("Winner 1")
            Text("Winner 2")
            Text("Winner 3")
            Text("Winner 4")
            Text("Winner 5")
        }
    }
}

struct WinnerView_Previews: PreviewProvider {
    static var previews: some View {
        WinnerView(players: [
            Player(id: UUID(), avatar: "avt_1", cash: 330, trains: 14, active: true),
            Player(id: UUID(), avatar: "avt_2", cash: 320, trains: 14, active: false),
            Player(id: UUID(), avatar: "avt_3", cash: 230, trains: 14, active: false),
            Player(id: UUID(), avatar: "avt_4", cash: 130, trains: 14, active: false),
            Player(id: UUID(), avatar: "avt_5", cash: 30, trains: 14, active: false)
        ]
        )
    }
}