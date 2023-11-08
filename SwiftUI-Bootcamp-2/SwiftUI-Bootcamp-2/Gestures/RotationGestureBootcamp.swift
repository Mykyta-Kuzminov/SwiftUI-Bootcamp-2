//
//  RotationGestureBootcamp.swift
//  SwiftUI-Bootcamp-2
//
//  Created by Микита Кузьмінов on 08.11.2023.
//

import SwiftUI

struct RotationGestureBootcamp: View {
    
    @State var angle: Angle = Angle(degrees: 0)
    
    var body: some View {
        Text("Hello, World!")
            .font(.title)
            .fontWeight(.semibold)
            .foregroundStyle(Color.white)
            .frame(width: 200, height: 200)
            .background(Color.blue)
            .clipShape(.rect(cornerRadius: 30))
            .rotationEffect(angle)
            .gesture(
                // Використовуємо для того, щоб можна було повертати зображення
                RotateGesture()
                // Виконує код, коли змінюється значення
                    .onChanged { value in
                        withAnimation(.default) {
                            angle = value.rotation
                        }
                    }
                // Виконує код після закінчення зміни значення
                    .onEnded { value in
                        withAnimation(.spring()) {
                            angle = Angle(degrees: 0)
                        }
                    }
            )
    }
}

#Preview {
    RotationGestureBootcamp()
}
