//
//  DynamicColorBootcamp.swift
//  SwiftUI-Bootcamp-2
//
//  Created by Микита Кузьмінов on 09.12.2023.
//

import SwiftUI

struct DynamicColorBootcamp: View {
    
    // Параметр, який визначає, чи повинна використовуватися прозорість в інтерфейсі користувача для покращення доступності на пристроях з вимкненою можливістю використовувати прозорість або на пристроях з включеним режимом покращеної доступності.
    @Environment(\.accessibilityReduceTransparency) var reduceTransparency
    
    // Параметр, який визначає чи змінено контрастність чи ні.
    @Environment(\.colorSchemeContrast) var colorSchemeContrast
    
    // Цей атрибут дозволяє забезпечити користувачам із зниженими можливостями зору чітке розрізнення між різними елементами інтерфейсу навіть у випадках, коли вони взаємодіють з інтерфейсом без використання кольорів.
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    
    // Цей атрибут вказує системі на зміну кольорів елементів інтерфейсу для полегшення їх сприйняття користувачами з різними видами знижених можливостей, зокрема із зниженими можливостями зору.
    @Environment(\.accessibilityInvertColors) var invertColors
    
    var body: some View {
        VStack {
            Button {
                // Code here...
            } label: {
                Text("Button 1")
                    .font(.headline)
                    .foregroundStyle(.black)
            }
            .frame(width: 100, height: 70)
            .background(reduceTransparency ? Color.gray : Color.gray.opacity(0.4))
            .clipShape(.rect(cornerRadius: 10))
            
            Button {
                // Code here...
            } label: {
                Text("Button 2")
                    .font(.headline)
                    .foregroundStyle(colorSchemeContrast == .increased ? .white : .black)
            }
            .frame(width: 100, height: 70)
            .background(Color.pink)
            .clipShape(.rect(cornerRadius: 10))
            
            Button {
                // Code here...
            } label: {
                Text("Button 3")
                    .font(.headline)
                    .foregroundStyle(differentiateWithoutColor ? .white : .white)
            }
            .frame(width: 100, height: 70)
            .background(differentiateWithoutColor ? .black : .green)
            .clipShape(.rect(cornerRadius: 10))
            
            Button {
                // Code here...
            } label: {
                Text("Button 4")
                    .font(.headline)
                    .foregroundStyle(.black)
            }
            .frame(width: 100, height: 70)
            .background(Color.yellow)
            .clipShape(.rect(cornerRadius: 10))
            .accessibilityIgnoresInvertColors(true)
        }
    }
}

#Preview {
    DynamicColorBootcamp()
}
