//
//  PlayerHUDView.swift
//  EngineYard
//
//  Created by Amarjit on 02/05/2023.
//

import SwiftUI

struct PlayerHUDView: View {
    let player: PlayerViewModel

    var body: some View {
            VStack(alignment: .leading, spacing: 8.0) {
                AvatarView(avatar: player.avatar)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8.0)
                            .stroke(Color.blue, lineWidth: 2)
                    )
                
                VStack(alignment: .leading, spacing: 5, content: {
                    Text(cashFormat( amount: player.cash))
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

struct PlayerHUDView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerHUDView(player: PlayerViewModel(id: UUID(), avatar: "avt-1", cash: 330, trains: 14, active: true, hand: nil))
    }
}
