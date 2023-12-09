//
//  DynamicTextBootcamp.swift
//  SwiftUI-Bootcamp-2
//
//  Created by Микита Кузьмінов on 09.12.2023.
//

import SwiftUI

struct DynamicTextBootcamp: View {
    
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(0..<10) { _ in
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: "heart.fill")
                            Text("Welcome to my App!")
                        }
                        .font(.title)
                        
                        Text("This is some longer text that expands to multiple lines.")
                            .font(.subheadline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .lineLimit(3)
                            /*
                             Люди, що мають проблеми з зором можуть використовувати збільшення тексту на їх смартфонах.
                             Для того, щоб UI виглядав гарно і не було ніяких костилів, потрібно робити текст динамічним для кожного збільшення або зменшення.
                             Текст буде динамічно підлаштовуватись під розмір шрифту.
                             */
                            .minimumScaleFactor(dynamicTypeSize.customMinScaleFactor)
                    }
                    .padding()
                    .background(Color.blue)
                }
            }
        }
    }
}

extension DynamicTypeSize {
    
    var customMinScaleFactor: CGFloat {
        switch self {
        case .xSmall, .small, .medium:
            return 1.0
        case .large, .xLarge, .xxLarge, .xxxLarge:
            return 0.8
        default:
            return 0.6
        }
    }
    
}

#Preview {
    DynamicTextBootcamp()
}
