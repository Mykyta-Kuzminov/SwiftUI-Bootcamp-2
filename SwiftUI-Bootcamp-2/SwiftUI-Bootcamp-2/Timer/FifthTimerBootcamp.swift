//
//  FifthTimerBootcamp.swift
//  SwiftUI-Bootcamp-2
//
//  Created by Микита Кузьмінов on 02.12.2023.
//

import SwiftUI

struct FifthTimerBootcamp: View {
    
    let timer = Timer.publish(every: 5.0, on: .main, in: .common).autoconnect()
    
    @State var count: Int = 0
    
    var body: some View {
        ZStack {
            RadialGradient(
                colors: [.first, .second],
                center: .center,
                startRadius: 5,
                endRadius: 500)
            .ignoresSafeArea()
            
            TabView(selection: $count) {
                Rectangle()
                    .fill(.red)
                    .tag(1)
                Rectangle()
                    .fill(.blue)
                    .tag(2)
                Rectangle()
                    .fill(.green)
                    .tag(3)
                Rectangle()
                    .fill(.yellow)
                    .tag(4)
                Rectangle()
                    .fill(.cyan)
                    .tag(5)
                
            }
            .frame(height: 200)
            .tabViewStyle(PageTabViewStyle())
        }
        .onReceive(timer, perform: { _ in
            withAnimation(.default) {
                count = count == 5 ? 0 : count + 1
            }
        })
    }
}

#Preview {
    FifthTimerBootcamp()
}
