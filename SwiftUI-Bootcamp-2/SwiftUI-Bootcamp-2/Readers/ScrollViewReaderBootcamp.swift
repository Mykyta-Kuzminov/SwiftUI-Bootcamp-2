//
//  ScrollViewReaderBootcamp.swift
//  SwiftUI-Bootcamp-2
//
//  Created by Микита Кузьмінов on 09.11.2023.
//

import SwiftUI

struct ScrollViewReaderBootcamp: View {
    
    @State var textFieldText: String = ""
    @State var scrollToIndex: Int = 0
    
    var body: some View {
        VStack {
            TextField("Enter a # here...", text: $textFieldText)
                .padding(.horizontal)
                .frame(height: 60)
                .frame(maxWidth: .infinity)
                .background(Color.gray.opacity(0.3))
                .clipShape(.rect(cornerRadius: 15))
            
            Button {
                withAnimation(.default) {
                    // Перевіряємо змінну textFieldText на значення nil
                    if let index = Int(textFieldText) {
                        scrollToIndex = index
                    }
                    
                    textFieldText = ""
                }
            } label: {
                Text("Scroll")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.white)
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .clipShape(.rect(cornerRadius: 15))
            }
            
            Text("Items")
                .font(.largeTitle)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ScrollView {
                // За допомогою ScrollViewReader ми можемо переміщуватись на будь-який елемент в ScrollView, що має індекс.
                ScrollViewReader { proxy in
                    ForEach(0..<30) { index in
                        Text("This is item #\(index)")
                            .font(.headline)
                            .frame(height: 250)
                            .frame(maxWidth: .infinity)
                            .background(.thinMaterial)
                        // Індекс, що потрібен для ідентифікації елемента
                            .id(index)
                    }
                // Спрацьовує коли змінна scrollToIndex змінює своє значення
                    .onChange(of: scrollToIndex) { oldValue, newValue in
                        withAnimation(.spring()) {
                            proxy.scrollTo(newValue, anchor: .top)
                        }
                    }
                }
            }
        }
        .padding()
        .ignoresSafeArea(edges: .bottom)
    }
}

#Preview {
    ScrollViewReaderBootcamp()
}
