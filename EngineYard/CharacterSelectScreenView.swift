//
//  CharacterSelectScreenView.swift
//  EngineYard
//
//  Created by Amarjit on 15/06/2023.
//

import SwiftUI

struct CharacterSelectScreenView: View {
    let images: [String]
    @State private var selectedButton: Int = 0
    
    var body: some View {
        HStack(alignment: .firstTextBaseline, spacing: 18, content: {
            VStack() {
                HStack() {
                    VStack() {
                        Text("Engine yard").font(.largeTitle)
                        Text("Choose your character").font(.largeTitle)
                    }
                }
                HStack (spacing: 5) {
                    //ForEach(avatars) { avt in
                    ForEach(0..<images.count) { index in
                        let img = images[index]
                        
                        Button(action: {
                            selectedButton = index
                        }) {
                            AvatarView(avatar: img).overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(selectedButton == index ? Color.blue : Color.clear, lineWidth: 4)
                            )                            
                        }
                    }
                    
                    
                }
                VStack {
                    
                    Button(action: {
                                // Action to perform when the button is clicked
                                print("Button clicked!")
                            }) {
                                Text("Start")
                                    .foregroundColor(.blue)
                                    .padding()
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.blue, lineWidth: 2)
                                    )
                                    .padding(.horizontal, 20)
                            }
                }
            }

        })
    }
}

struct CharacterSelectScreenView_Previews: PreviewProvider {
    static var previews: some View {
        
        let images = [
            "avt-1",
            "avt-2",
            "avt-3",
            "avt-4",
            "avt-5"
        ]
        
        CharacterSelectScreenView(images: images)
    }
}
