//
//  ThirdTimerBootcamp.swift
//  SwiftUI-Bootcamp-2
//
//  Created by Микита Кузьмінов on 02.12.2023.
//

import SwiftUI

struct ThirdTimerBootcamp: View {
    
    @State var timeRemaining: String = ""
    
    let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    let futureDate = Calendar.current.date(byAdding: .hour, value: 1, to: Date()) ?? Date()
    
    func updateTimeRemaining() {
        let remaining = Calendar.current.dateComponents([.minute, .second], from: Date(), to: futureDate)
        let minute = remaining.minute ?? 0
        let second = remaining.second ?? 0
        timeRemaining = "\(minute) : \(second)"
    }
    
    var body: some View {
        ZStack {
            RadialGradient(
                colors: [.first, .second],
                center: .center,
                startRadius: 5,
                endRadius: 500)
            .ignoresSafeArea()
            
            Text(timeRemaining)
                .font(.system(size: 80, weight: .semibold, design: .rounded))
                .foregroundStyle(.white)
                .lineLimit(1)
                
        }
        .onReceive(timer, perform: { _ in
            updateTimeRemaining()
        })
    }
}

#Preview {
    ThirdTimerBootcamp()
}
