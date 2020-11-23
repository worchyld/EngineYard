//
//  AvatarView.swift
//  EngineYard
//
//  Created by Amarjit on 06/11/2020.
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
