//
//  SingleLocomotiveCellView.swift
//  EngineYard
//
//  Created by Amarjit on 20/11/2020.
//

import SwiftUI

struct SingleLocomotiveCellView: View {
    let locomotive: Locomotive
    var body: some View {
        HStack(alignment: .center, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/, content: {
            Image("icon-train")
            Text("\(locomotive.name)").font(.headline)
            Text("\(locomotive.generation.description.capitalizingFirstLetter())")
            Text("\(locomotive.livery.description.capitalizingFirstLetter())")
            Text(cashFormat(amount: locomotive.cost))
                .font(.headline)
                .fontWeight(.bold)
        })
    }
}

struct SingleLocomotiveCellView_Previews: PreviewProvider {
    static var previews: some View {
        SingleLocomotiveCellView(locomotive: Locomotive(id: UUID(), name: "Green.1", image: "icon-train", cost: 4, livery: .green, generation: .first, rust: .new, available: false))
    }
}
