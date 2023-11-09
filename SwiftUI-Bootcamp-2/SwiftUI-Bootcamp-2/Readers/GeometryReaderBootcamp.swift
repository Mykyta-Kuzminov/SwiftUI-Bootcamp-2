//
//  GeometryReaderBootcamp.swift
//  SwiftUI-Bootcamp-2
//
//  Created by Микита Кузьмінов on 09.11.2023.
//

import SwiftUI

struct GeometryReaderBootcamp: View {
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(0..<21) { index in
                // Використовуємо GeometryReader, коли потрібно знати розміри та положення об'єкта на екрані.
                    GeometryReader { proxy in
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .rotation3DEffect(
                                    Angle(degrees: getRotationValue(geometry: proxy) * 10),
                                    axis: /*@START_MENU_TOKEN@*/(x: 0.0, y: 1.0, z: 0.0)/*@END_MENU_TOKEN@*/
                                )
                            // Proxy дає всі значення об'єкта
                            Text("\(proxy.frame(in: .global).midX)")
                                .foregroundStyle(.white)
                        }
                    }
                    .frame(width: 300, height: 250)
                    .padding()
                }
            }
        }
    }
    
    // Функція повертає значення повороту картки
    func getRotationValue(geometry: GeometryProxy) -> Double {
        let width: CGFloat = 210
        let currentX = geometry.frame(in: .global).midX
        return Double(1 - (currentX / width))
    }
}

#Preview {
    GeometryReaderBootcamp()
}
