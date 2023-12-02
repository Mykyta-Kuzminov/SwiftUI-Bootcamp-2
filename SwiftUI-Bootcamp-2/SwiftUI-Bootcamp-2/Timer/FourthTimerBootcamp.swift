//
//  FourthTimerBootcamp.swift
//  SwiftUI-Bootcamp-2
//
//  Created by Микита Кузьмінов on 02.12.2023.
//

import SwiftUI

struct FourthTimerBootcamp: View {
    
    let timer = Timer.publish(every: 0.3, on: .main, in: .common).autoconnect()
    
    @State var count = 0
    
    var body: some View {
        ZStack {
            RadialGradient(
                colors: [.first, .second],
                center: .center,
                startRadius: 5,
                endRadius: 500)
            .ignoresSafeArea()
            
            HStack {
                Circle()
                    .offset(y: count == 1 ? -20 : 0)
                Circle()
                    .offset(y: count == 2 ? -20 : 0)
                Circle()
                    .offset(y: count == 3 ? -20 : 0)
            }
            .frame(width: 200)
            .foregroundStyle(.white)
        }
        .onReceive(timer, perform: { _ in
            withAnimation(.easeOut) {
                count = count == 3 ? 0 : count + 1
            }
        })
    }
}

#Preview {
    FourthTimerBootcamp()
}
