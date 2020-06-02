//
//  ContentView.swift
//  EngineYard
//
//  Created by Amarjit on 02/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let cards: [Card]

    var body: some View {
        Text("We see: \(cards.count)")
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(cards: Card.build())
    }
}
#endif
