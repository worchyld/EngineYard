//
//  AvatarView.swift
//  EngineYard
//
//  Created by Amarjit on 02/05/2023.
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

struct AvatarView_Previews: PreviewProvider {
    static var previews: some View {
        AvatarView(avatar: "avt-1")
    }
}
