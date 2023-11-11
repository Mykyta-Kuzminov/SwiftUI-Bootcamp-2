//
//  SoundsBootcamp.swift
//  SwiftUI-Bootcamp-2
//
//  Created by Микита Кузьмінов on 11.11.2023.
//

import SwiftUI

struct SoundsBootcamp: View {
    var body: some View {
        VStack {
            ButtonView(title: "Game over", sound: .gameover)
            ButtonView(title: "Notification", sound: .notification)
        }
    }
}

struct ButtonView: View {
    
    let title: String
    let sound: SoundOption
    
    var body: some View {
        Button {
            SoundManager.instance.playSound(sound: sound)
        } label: {
            Text(title)
                .font(.title3)
                .fontWeight(.semibold)
                .frame(width: 120, height: 50)
        }
        .buttonStyle(.bordered)
        .controlSize(.large)
    }
}

#Preview {
    SoundsBootcamp()
}
