//
//  SecondTimerBootcamp.swift
//  SwiftUI-Bootcamp-2
//
//  Created by Микита Кузьмінов on 02.12.2023.
//

import SwiftUI

struct SecondTimerBootcamp: View {
    
    let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    @State var currentDate = Date()
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        return formatter
    }
    
    var body: some View {
        ZStack {
            RadialGradient(
                colors: [.first, .second],
                center: .center,
                startRadius: 5,
                endRadius: 500)
            .ignoresSafeArea()
            
            Text(dateFormatter.string(from: currentDate))
                .font(.system(size: 80, weight: .semibold, design: .rounded))
                .foregroundStyle(.white)
                .lineLimit(1)
                
        }
        .onReceive(timer, perform: { value in
            currentDate = value
        })
    }
}

#Preview {
    SecondTimerBootcamp()
}
