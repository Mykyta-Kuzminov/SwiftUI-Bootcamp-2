//
//  HapticsBootcamp.swift
//  SwiftUI-Bootcamp-2
//
//  Created by Микита Кузьмінов on 11.11.2023.
//

import SwiftUI

class HapticManager {
    
    // Singleton
    static let instance = HapticManager()
    
    // Цей генератор використовується для надання звукового та вібраційного зворотного зв'язку, який сповіщає користувача про важливу інформацію або подію.
    func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
    // Цей генератор призначений для імітації впливу або удару.
    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
    
}

struct HapticsBootcamp: View {
    var body: some View {
        VStack {
            Button("Success") { HapticManager.instance.notification(type: .success) }
            Button("Warning") { HapticManager.instance.notification(type: .warning) }
            Button("Error") { HapticManager.instance.notification(type: .error) }  
            Divider()
            Button("Soft") { HapticManager.instance.impact(style: .soft) }
            Button("Light") { HapticManager.instance.impact(style: .light) }
            Button("Medium") { HapticManager.instance.impact(style: .medium) }
            Button("Rigid") { HapticManager.instance.impact(style: .rigid) }
            Button("Heavy") { HapticManager.instance.impact(style: .heavy) }
        }
    }
}

#Preview {
    HapticsBootcamp()
}
