//
//  MagnificationGestureBootcamp.swift
//  SwiftUI-Bootcamp-2
//
//  Created by Микита Кузьмінов on 07.11.2023.
//

import SwiftUI

struct MagnificationGestureBootcamp: View {
    
    @State var currentValue: CGFloat = 1
    
    var body: some View {
        VStack {
            HStack {
                Circle()
                    .frame(width: 40, height: 40)
                Text("Swiftful Thinking")
                Spacer()
                Image(systemName: "ellipsis")
            }
            .padding(.horizontal)
            
            Rectangle()
                .scaleEffect(currentValue)
                .frame(maxWidth: .infinity, maxHeight: 350)
            // Використовуємо для того, щоб можна було збільшувати або зменшувати зображення
                .gesture(
                    MagnificationGesture()
                    // Виконує код під час зміни значення gesture
                        .onChanged { value in
                            withAnimation(.default) {
                                currentValue = value
                            }
                        }
                    // Виконує код по закінченню
                        .onEnded { value in
                            withAnimation(.spring()) {
                                currentValue = 1
                            }
                        }
                )
        }
    }
}

#Preview {
    MagnificationGestureBootcamp()
}
