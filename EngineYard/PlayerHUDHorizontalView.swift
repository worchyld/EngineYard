//
//  PlayerHUDHorizontalView.swift
//  EngineYard
//
//  Created by Amarjit on 19/11/2020.
//

import SwiftUI

struct PlayerHUDHorizontalView: View {
    let player: Player

    var body: some View {
        HStack(alignment: .top, spacing: 3.0, content: {

            if (player.active) {
            AvatarView(avatar: player.avatar)
                .overlay(
                    RoundedRectangle(cornerRadius: 8.0)
                        .stroke(Color.blue, lineWidth: 2)
                )
            } else {
                AvatarView(avatar: player.avatar)
            }
            
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
            }).padding(.leading, 7.0)
            
        })
        
    }
}

struct PlayerHUDHorizontalView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerHUDHorizontalView(player:
                                    Player(id: UUID(), avatar: "avt_1", cash: 330, trains: 14, active: true))
    }
}
