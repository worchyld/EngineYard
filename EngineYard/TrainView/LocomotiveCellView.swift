//
//  SingleLocomotiveCellView.swift
//  EngineYard
//
//  Created by Amarjit on 20/11/2020.
//

import SwiftUI

struct LocomotiveCellView: View {
    let locomotive: LocomotiveViewModel
    var body: some View {
        HStack(alignment: .center, spacing: 1.0, content: {
            Image(locomotive.image).resizable().frame(width: 35, height: 25, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            VStack(alignment: .leading, spacing: 1.0, content: {
                Text("\(locomotive.name)").font(.headline)
                HStack {
                    Text("\(locomotive.generation.ordinalFormat ?? "nil") Generation").font(.caption)
                    Text("\(locomotive.livery.description.capitalizingFirstLetter())").font(.caption)
                }
            }).frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .topLeading).padding(.leading, 15)
            
            // cost
            Text(cashFormat(amount: locomotive.cost))
                .font(.headline)
                .fontWeight(.bold)
        }).frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .center)
    }
}

struct SingleLocomotiveCellView_Previews: PreviewProvider {
    static var previews: some View {
        LocomotiveCellView(locomotive: LocomotiveViewModel(id: UUID(), name: "Green.1", image: "icon-train-green", cost: 4, livery: .green, generation: .first, rust: .new, available: false))
    }
}
