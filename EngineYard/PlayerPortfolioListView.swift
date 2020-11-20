//
//  PlayerPortfolioListView.swift
//  EngineYard
//
//  Created by Amarjit on 20/11/2020.
//

import SwiftUI

struct PlayerPortfolioListView: View {
    let player: Player
    let locomotives: [Locomotive]
    var body: some View {
        NavigationView {
            List {
                Section(header: PlayerPortfolioHeaderView(player: player)) {
                    ForEach(locomotives) { locomotive in
                       SingleLocomotiveCellView(locomotive: locomotive)
                    }
                }
            }
            .navigationBarTitle("💼 My Portfolio")
        }
    }
}

struct PlayerPortfolioHeaderView: View {
    let player: Player
    var body: some View {
        PlayerHUDHorizontalView(player: player).padding([.top, .bottom], 10.0)
    }
}

struct PlayerPortfolioListView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerPortfolioListView(player: Player(id: UUID(), avatar: "avt-1", cash: 3, trains: 0, active: false),
                                locomotives: [
            Locomotive(id: UUID(), name: "Green.1", image: "icon-train", cost: 4, livery: .green, generation: .first, rust: .new, available: false),
            Locomotive(id: UUID(), name: "Red.1", image: "icon-train", cost: 8, livery: .green, generation: .first, rust: .new, available: false),
            Locomotive(id: UUID(), name: "Yellow.1", image: "icon-train", cost: 12, livery: .green, generation: .first, rust: .new, available: false),
            Locomotive(id: UUID(), name: "Blue.1", image: "icon-train", cost: 16, livery: .green, generation: .first, rust: .new, available: false),
            Locomotive(id: UUID(), name: "Green.2", image: "icon-train", cost: 20, livery: .green, generation: .second, rust: .new, available: false),
            Locomotive(id: UUID(), name: "Green.1", image: "icon-train", cost: 24, livery: .green, generation: .first, rust: .new, available: false),
            Locomotive(id: UUID(), name: "Red.2", image: "icon-train", cost: 28, livery: .red, generation: .second, rust: .new, available: false),
            Locomotive(id: UUID(), name: "Yellow.2", image: "icon-train", cost: 32, livery: .yellow, generation: .second, rust: .new, available: false),
            Locomotive(id: UUID(), name: "Green.3", image: "icon-train", cost: 36, livery: .green, generation: .third, rust: .new, available: false),
            Locomotive(id: UUID(), name: "Blue.2", image: "icon-train", cost: 30, livery: .blue, generation: .second, rust: .new, available: false),
            Locomotive(id: UUID(), name: "Red.3", image: "icon-train", cost: 44, livery: .red, generation: .third, rust: .new, available: false),
            Locomotive(id: UUID(), name: "Green.4", image: "icon-train", cost: 48, livery: .green, generation: .fourth, rust: .new, available: false),
            Locomotive(id: UUID(), name: "Yellow.3", image: "icon-train", cost: 52, livery: .green, generation: .third, rust: .new, available: false),
            Locomotive(id: UUID(), name: "Green.5", image: "icon-train", cost: 56, livery: .green, generation: .fifth, rust: .new, available: false)
        ])
    }
}
