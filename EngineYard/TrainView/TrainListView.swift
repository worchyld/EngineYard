//
//  TrainListView.swift
//  EngineYard
//
//  Created by Amarjit on 20/11/2020.
//

import SwiftUI

struct TrainListView: View {
    let locomotives: [Locomotive]
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
        TrainListView(locomotives: [
            Locomotive(id: UUID(), name: "Green.1", image: "icon-train-green", cost: 4, livery: .green, generation: .first, rust: .new, available: false),
            Locomotive(id: UUID(), name: "Red.1", image: "icon-train-red", cost: 8, livery: .green, generation: .first, rust: .new, available: false),
            Locomotive(id: UUID(), name: "Yellow.1", image: "icon-train-yellow", cost: 12, livery: .green, generation: .first, rust: .new, available: false),
            Locomotive(id: UUID(), name: "Blue.1", image: "icon-train-blue", cost: 16, livery: .green, generation: .first, rust: .new, available: false),
            Locomotive(id: UUID(), name: "Green.2", image: "icon-train-green", cost: 20, livery: .green, generation: .second, rust: .new, available: false),
            Locomotive(id: UUID(), name: "Green.1", image: "icon-train-green", cost: 24, livery: .green, generation: .first, rust: .new, available: false),
            Locomotive(id: UUID(), name: "Red.2", image: "icon-train-red", cost: 28, livery: .red, generation: .second, rust: .new, available: false),
            Locomotive(id: UUID(), name: "Yellow.2", image: "icon-train-yellow", cost: 32, livery: .yellow, generation: .second, rust: .new, available: false),
            Locomotive(id: UUID(), name: "Green.3", image: "icon-train-green", cost: 36, livery: .green, generation: .third, rust: .new, available: false),
            Locomotive(id: UUID(), name: "Blue.2", image: "icon-train-blue", cost: 30, livery: .blue, generation: .second, rust: .new, available: false),
            Locomotive(id: UUID(), name: "Red.3", image: "icon-train-red", cost: 44, livery: .red, generation: .third, rust: .new, available: false),
            Locomotive(id: UUID(), name: "Green.4", image: "icon-train-green", cost: 48, livery: .green, generation: .fourth, rust: .new, available: false),
            Locomotive(id: UUID(), name: "Yellow.3", image: "icon-train-yellow", cost: 52, livery: .green, generation: .third, rust: .new, available: false),
            Locomotive(id: UUID(), name: "Green.5", image: "icon-train-green", cost: 56, livery: .green, generation: .fifth, rust: .new, available: false)
        ])
    }
}
