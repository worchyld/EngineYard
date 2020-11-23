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
        HStack(alignment: .center, spacing: 1.0, content: {
            Image("icon-train").resizable().frame(width: 35, height: 25, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            VStack(alignment: .leading, spacing: 1.0, content: {
                HStack(alignment: .center, spacing: 1.0, content: {
                    Text("\(locomotive.name)").font(.headline)
                    Text("\(locomotive.livery.description.capitalizingFirstLetter())").padding(.leading, 8.0)
                })
                Text("\(locomotive.generation.ordinalFormat ?? "nil") Generation").font(.caption)
            }).frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .topLeading).padding(.leading, 15)
            
            Text(cashFormat(amount: locomotive.cost))
                .font(.headline)
                .fontWeight(.bold)
        }).frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .center)
    }
}

struct SingleLocomotiveCellView_Previews: PreviewProvider {
    static var previews: some View {
        SingleLocomotiveCellView(locomotive: Locomotive(id: UUID(), name: "Green.1", image: "icon-train-green", cost: 4, livery: .green, generation: .first, rust: .new, available: false))
    }
}
