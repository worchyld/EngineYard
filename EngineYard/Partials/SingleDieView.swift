//
//  SingleDieView.swift
//  EngineYard
//
//  Created by Amarjit on 08/05/2023.
//

import SwiftUI

struct SingleDieView: View {
    let die: Int
    var body: some View {
        Image("die-\(die)")
    }
}

struct SingleDieView_Previews: PreviewProvider {
    static var previews: some View {
        SingleDieView(die: D6.roll)
    }
}
