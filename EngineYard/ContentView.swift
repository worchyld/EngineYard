//
//  ContentView.swift
//  EngineYard
//
//  Created by Amarjit on 02/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        VStack(alignment: .leading, spacing: 3.0) {
            HStack(alignment: .top, spacing: 8.0) {
                AvatarMiniProfile(avatar: "avt_1")
                AvatarMiniProfile(avatar: "avt_2")
                AvatarMiniProfile(avatar: "avt_3")
                AvatarMiniProfile(avatar: "avt_4")
                AvatarMiniProfile(avatar: "avt_5")
            }.padding([.leading], 10)
        }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
