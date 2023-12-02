//
//  TimerBootcamp.swift
//  SwiftUI-Bootcamp-2
//
//  Created by Микита Кузьмінов on 02.12.2023.
//

import SwiftUI

struct FirstTimerBootcamp: View {
    
    // Створюємо Publisher з використанням класу Timer, який автоматично відправляє події кожну 1.0 секунду.
    // Використовуємо .autoconnect() для автоматичного управління з'єднанням з Timer.publish.
    let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    @State var count: Int = 10
    @State var finishedText: String? = nil
    
    var body: some View {
        ZStack {
            RadialGradient(
                colors: [.first, .second],
                center: .center,
                startRadius: 5,
                endRadius: 500)
            .ignoresSafeArea()
            
            Text(finishedText ?? "\(count)")
                .font(.system(size: 100, weight: .semibold, design: .rounded))
                .foregroundStyle(.white)
                .lineLimit(1)
                .minimumScaleFactor(0.1)
        }
        // Отримуємо події після яких виконується нам потрібний код
        .onReceive(timer, perform: { value in
            if count < 1 {
                withAnimation(.default) {
                    finishedText = "Wow!"
                }
            } else {
                withAnimation(.default) {
                    count -= 1
                }
            }
        })
    }
}

#Preview {
    FirstTimerBootcamp()
}
