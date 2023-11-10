//
//  MaskBootcamp.swift
//  SwiftUI-Bootcamp-2
//
//  Created by Микита Кузьмінов on 10.11.2023.
//

import SwiftUI

struct MaskBootcamp: View {
    
    let gradient = LinearGradient(colors: [.yellow, .orange], startPoint: .leading, endPoint: .trailing)
    
    @State var currentStar: Int = 1
    
    var body: some View {
        starsView
            .overlay {
                maskView
                // Накладує маску поверх зображення
                    .mask(starsView)
            }
    }
    
    private var maskView: some View {
        // Використав GeometryReader для того щоб зафарбовувати кількість поставлених зірок в залежності від розміру прямокутника
        GeometryReader { geometry in
            Rectangle()
                .fill(gradient)
                .frame(width: CGFloat(currentStar) / 5 * geometry.size.width)
        }
        // Вимкнув дозвіл натискання на це зображення, щоб зображення під маскою можна було змінювати при її накладанні
        .allowsHitTesting(false)
    }
    
    private var starsView: some View {
        HStack {
            ForEach(1..<6) { index in
                Image(systemName: "star.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(Color.gray)
                    .frame(width: 50, height: 50)
                    .onTapGesture {
                        withAnimation(.default) {
                            currentStar = index
                        }
                    }
            }
        }
    }
}

#Preview {
    MaskBootcamp()
}
