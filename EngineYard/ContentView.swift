//
//  ContentView.swift
//  EngineYard
//
//  Created by Amarjit on 02/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import SwiftUI

struct AvatarView: View {
    let avatar: String

    var body: some View {
        Image(avatar)
            .resizable()
            .clipShape(
                RoundedRectangle(cornerRadius: 6.0, style: .continuous)
            )
            .clipped()
            .aspectRatio(1.0, contentMode: .fit)
            .frame(maxWidth: 50, maxHeight: 50, alignment: .topLeading)

    }
}

struct AvatarMiniProfile: View {
    let avatar: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8.0) {
            AvatarView(avatar: avatar)
                .overlay(
                    RoundedRectangle(cornerRadius: 8.0)
                        .stroke(Color.blue, lineWidth: 2)
                )

            Text("$330")
                .font(.caption)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)

        }
    }
}

struct ContentView: View {
    let cards: [Card]

    var body: some View {
        VStack(alignment: .leading, spacing: 3.0) {
            HStack(alignment: .top, spacing: 8.0) {
                AvatarMiniProfile(avatar: "avt_1")
                AvatarMiniProfile(avatar: "avt_2")
                AvatarMiniProfile(avatar: "avt_3")
                AvatarMiniProfile(avatar: "avt_4")
                AvatarMiniProfile(avatar: "avt_5")
            }.padding([.leading], 10)

            List(cards) { card in
                Text(card.name)
            }
        }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(cards: Card.build())
    }
}
#endif
