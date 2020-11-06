//
//  DieView.swift
//  EngineYard
//
//  Created by Amarjit on 06/11/2020.
//

import SwiftUI

struct DieView: View {
    let die: Int
    var body: some View {
        Image("die-\(die)")
    }
}

struct DieView_Previews: PreviewProvider {
    static var previews: some View {
        DieView(die: Die.roll)
    }
}
