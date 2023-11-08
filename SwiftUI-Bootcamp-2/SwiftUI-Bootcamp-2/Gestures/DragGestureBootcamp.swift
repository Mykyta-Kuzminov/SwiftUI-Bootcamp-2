//
//  DragGestureBootcamp.swift
//  SwiftUI-Bootcamp-2
//
//  Created by Микита Кузьмінов on 08.11.2023.
//

import SwiftUI

struct DragGestureBootcamp: View {
    
    @State var offset: CGSize = .zero
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .fill(.thinMaterial)
                .frame(width: 300, height: 500)
                .shadow(color: getShadowColor(),
                        radius: 10,
                        x: getXShadowOffset(),
                        y: 7)
            
            VStack {
                Image(systemName: "waveform.circle")
                    .frame(maxWidth: .infinity ,alignment: .leading)
                Spacer()
                Text("treat")
                Spacer()
            }
            .font(.title)
            .fontWeight(.semibold)
            .frame(width: 250, height: 450)
            .foregroundStyle(Color.primary)
        }
        .offset(offset)
        .scaleEffect(getScaleAmount())
        .gesture(
            // Використовуємо, коли потрібно змінювати положення елемента
            DragGesture()
            // Виконує код, коли змінюється значення
                .onChanged { value in
                    withAnimation(.default) {
                        offset = value.translation
                    }
                }
            // Виконує код після закінчення зміни значення
                .onEnded { value in
                    withAnimation(.spring()) {
                        offset = .zero
                    }
                }
        )
    }
    
    // Функція зменшує розмір картки в залежності її положення
    func getScaleAmount() -> CGFloat {
        let maxWidth: CGFloat = 200
        let currentAmount = abs(offset.width)
        let percentage = currentAmount / maxWidth
        return 1.0 - min(percentage, 0.5) * 0.5
        
    }
    
    // Функція повертає колір тіні картки в залежності її положення
    func getShadowColor() -> Color {
        let currentAmount = offset.width
        var color = Color.clear
        if currentAmount > 0 {
            color = Color.green
        } else if currentAmount < 0 {
            color = Color.orange
        } else {
            color = .clear
        }
        return color
    }
    
    
    // Функція повертає значення, що зміщує тінь картки в залежності її положення
    func getXShadowOffset() -> CGFloat {
        let currentAmount = offset.width
        var offset: CGFloat = 0
        if currentAmount > 0 {
            offset = 7
        } else if currentAmount < 0 {
            offset = -7
        } else {
            offset = 0
        }
        return offset
    }
}

#Preview {
    DragGestureBootcamp()
}
