//
//  AvatarView.swift
//  EngineYard
//
//  Created by Amarjit on 17/06/2020.
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

#if DEBUG
struct AvatarView_Previews: PreviewProvider {
    static var previews: some View {
        AvatarMiniProfile(avatar: "avt_1")
    }
}
#endif
