//
//  LocomotiveCellView.swift
//  EngineYard
//
//  Created by Amarjit on 08/05/2023.
//

import SwiftUI

struct LocomotiveCellView: View {
    let locomotive: LocomotiveViewModel
    
    var body: some View {
        HStack(alignment: .center, spacing: 1.0, content: {
            
            VStack(alignment: .center, content: {
                HStack(alignment: .center, content: {
                    Text(cashFormat(amount: locomotive.cost)).font(.largeTitle).bold()
                    Text(cashFormat(amount:locomotive.productionCost)).font(.title)
                    Text(cashFormat(amount:locomotive.income)).font(.title)
                })
                Text("\(locomotive.generation.rawValue)").font(.largeTitle).bold()
                Image(locomotive.icon).resizable().frame(width: 35, height: 25, alignment: .center)
            })
            
            
            
            /*
            Image(locomotive.icon).resizable().frame(width: 35, height: 25, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        VStack(alignment: .leading, spacing: 1.0, content: {
                            Text("\(locomotive.name)").font(.headline)
                            HStack {
                                Text("\(locomotive.generation.rawValue.ordinalFormat ?? "nil") Generation").font(.caption)
                                Text("\(locomotive.colour.description.capitalizingFirstLetter())").font(.caption)
                            }
                        }).frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .topLeading).padding(.leading, 15)
                    // cost
                    Text(cashFormat(amount: locomotive.cost))
                        .font(.headline)
                        .fontWeight(.bold)
             */
                }).frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .center)
    }
}

struct LocomotiveCellView_Previews: PreviewProvider {
    static var previews: some View {
        LocomotiveCellView(locomotive: LocomotiveViewModel(with: Locomotive(id: UUID(), name: "Green-1", colour: .green, generation: .first, cost: 4, trainPool: 4, capacity: 4, rust: .notBuilt, orders: [Int](), sales: [Int](), initialOrder: nil)))

    }
}
