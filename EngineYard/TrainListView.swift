//
//  TrainListView.swift
//  EngineYard
//
//  Created by Amarjit on 08/05/2023.
//

import SwiftUI

struct TrainListView: View {
    let locomotives: [LocomotiveViewModel]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(locomotives) { locomotive in
                    LocomotiveCellView(locomotive: locomotive)
                }
            }
            .navigationBarTitle("🚂 Locomotives")
        }
    }
}

struct TrainListView_Previews: PreviewProvider {
    static var previews: some View {
        TrainListView(
            locomotives: [
                LocomotiveViewModel(with: Locomotive(id: UUID(), name: "Green-1", colour: .green, generation: .first, cost: 4, trainPool: 4, capacity: 3, rust: .notBuilt, orders: [Int](), sales: [Int](), initialOrder: nil)),
                LocomotiveViewModel(with: Locomotive(id: UUID(), name: "Green-1", colour: .green, generation: .first, cost: 4, trainPool: 4, capacity: 3, rust: .notBuilt, orders: [Int](), sales: [Int](), initialOrder: nil)),
                LocomotiveViewModel(with: Locomotive(id: UUID(), name: "Green-1", colour: .green, generation: .first, cost: 4, trainPool: 4, capacity: 3, rust: .notBuilt, orders: [Int](), sales: [Int](), initialOrder: nil))
            ]
        )
    }
}
