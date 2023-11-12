//
//  NotificationsBootcamp.swift
//  SwiftUI-Bootcamp-2
//
//  Created by Микита Кузьмінов on 12.11.2023.
//

import SwiftUI

struct NotificationsBootcamp: View {
    var body: some View {
        VStack {
            SecondButtonView(title: "Request permission") {
                NotificationManager.instance.requestAutorization()
            }
            
            SecondButtonView(title: "Time notification") {
                NotificationManager.instance.timeNotification()
            }
            
            SecondButtonView(title: "Calendar notification") {
                NotificationManager.instance.calendarNotification()
            }
            
            SecondButtonView(title: "Location notification") {
                NotificationManager.instance.locationNotification()
            }
            
            SecondButtonView(title: "Cancel notifications") {
                NotificationManager.instance.cancelNotification()
            }
        }
    }
}

struct SecondButtonView: View {
    
    let title: String
    let code: () -> ()
    
    var body: some View {
        Button {
            code()
        } label: {
            Text(title)
                .font(.title3)
                .fontWeight(.semibold)
                .frame(width: 200)
        }
        .buttonStyle(.borderedProminent)
        .controlSize(.large)
    }
}

#Preview {
    NotificationsBootcamp()
}
