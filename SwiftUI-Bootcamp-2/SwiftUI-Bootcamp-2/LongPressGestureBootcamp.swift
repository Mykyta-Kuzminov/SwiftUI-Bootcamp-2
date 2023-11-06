//
//  LongPressGestureBootcamp.swift
//  SwiftUI-Bootcamp-2
//
//  Created by Микита Кузьмінов on 06.11.2023.
//

import SwiftUI

struct LongPressGestureBootcamp: View {
    
    @State var isPressed: Bool = false
    @State var isCompleted: Bool = false
    
    var body: some View {
        VStack(spacing: 100) {
            ZStack {
                // Сірий задній фон
                Circle()
                    .stroke(lineWidth: 5.0)
                    .fill(Color.gray.opacity(0.5))
                    .frame(width: 200, height: 200)
                
                // Передній фон, що змінює свій колір та заповненість в залежності від часу натискання кнопки
                Circle()
                    .trim(from: isPressed ? 0.0 : 1.0, to: 1.0)
                    .stroke(lineWidth: 5.0)
                    .fill(isCompleted ? Color.green : Color.red)
                    .frame(width: 200, height: 200)
                
                // Інформаційний текст, що змінюється від часу натискання кнопки
                Text(isCompleted ? "Success" : "Failure")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .fontDesign(.serif)
                    .foregroundStyle(isCompleted ? Color.green : Color.red)
                    .shadow(color: isCompleted ? Color.green.opacity(0.4) : Color.red.opacity(0.4), radius: 5)
            }
            // Скидання змінних
            .onTapGesture {
                withAnimation(.default) {
                    isPressed = false
                    isCompleted = false
                }
            }
            
            Image(systemName: "button.programmable")
                .resizable()
                .renderingMode(.template)
                .frame(width: 70, height: 70)
                .foregroundStyle(Color(UIColor.red))
                /*
                 LongPressGesture - це теж саме, що й звичайний TapGesture, але за допомогою нього можна створювати кнопки, які потрібно натискати якийсь час.
                 
                 Параметр minimumDuration вказує на те, скільки часу потрібно натискати на кнопку.
                 
                 Параметр maximumDistance вказує на те, на скільки ми можемо відхилити наш палець від початкового місцезнаходження під час натискання кнопки.
                 
                 Також має два клоужери, перший з яких perform, який відповідає за виконання коду після maximumDuration. Та другий onPressingChanged, що виконує код під час натискання кнопки.
                 */
                .onLongPressGesture(
                    minimumDuration: 2.0,
                    maximumDistance: 50) {
                        withAnimation(.easeInOut) {
                            isCompleted = true
                        }
                    } onPressingChanged: { isPressing in
                        if isPressing {
                            withAnimation(.easeInOut(duration: 2.0)) {
                                isPressed = true
                            }
                        } else {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                if !isCompleted {
                                    withAnimation(.easeInOut) {
                                        isPressed = false
                                    }
                                }
                            }
                        }
                    }
        }
    }
}

#Preview {
    LongPressGestureBootcamp()
}
