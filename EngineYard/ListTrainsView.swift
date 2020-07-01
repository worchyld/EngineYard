//
//  ListTrainsView.swift
//  EngineYard
//
//  Created by Amarjit on 01/07/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import SwiftUI

struct ListTrainsView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("🚂")
            Text("Locomotives")
                .font(.largeTitle)
            Text("Pick a locomotive to purchase")

            Image("card-1")
            .resizable()
                .frame(width: 200, height: 130, alignment: .leading)
                .cornerRadius(20)

            Text("Cost : $4")
            Text("Production: $2")
            Text("Income $1")
            Text("Existing Orders:")
            Text("⚀ ⚁ ⚂ ⚃ ⚄ ⚅")
            Text("Completed Orders:")
            //Text("⚀ ⚁ ⚂ ⚃ ⚄ ⚅")
        }
    }
}

#if DEBUG
struct ListTrainsView_Previews: PreviewProvider {
    static var previews: some View {
        ListTrainsView()
    }
}
#endif

