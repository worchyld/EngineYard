//
//  LocomotiveProductionCellView.swift
//  EngineYard
//
//  Created by Amarjit on 23/11/2020.
//

import SwiftUI

struct LocomotiveProductionCellView: View {
    let locomotive: LocomotiveViewModel
    let productionUnits: Int
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
            
            // production units
            Text("\(productionUnits) units")
                .font(.headline)
                .fontWeight(.bold)
        }).frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .center)
    }
}

struct LocomotiveProductionCellView_Previews: PreviewProvider {
    static var previews: some View {
        LocomotiveProductionCellView(locomotive: LocomotiveViewModel(id: UUID(), name: "Green.1", image: "icon-train-green", cost: 4, livery: .green, generation: .first, rust: .new, available: false), productionUnits: 3)
    }
}
