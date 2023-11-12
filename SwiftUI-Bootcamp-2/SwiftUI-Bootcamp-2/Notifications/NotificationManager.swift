//
//  NotificationManager.swift
//  SwiftUI-Bootcamp-2
//
//  Created by Микита Кузьмінов on 12.11.2023.
//

import Foundation
import UserNotifications
import CoreLocation

class NotificationManager {
    
    // Singleton
    static let instance = NotificationManager()
    
    // Запрос на отримання дозволу відправляти повідомлення
    func requestAutorization() {
        
        // Опції, що будуть використані для повідомлень
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        
        // Викликаємо UserNotificationCenter для відправлення запиту на дозвіл та його обробці
        UNUserNotificationCenter.current().requestAuthorization(options: options) { success, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else {
                print("Success")
            }
        }
    }
    
    // Повідомлення за часом
    func timeNotification() {
        
        // Контент повідомлення, що має мати пункти з options
        let content = UNMutableNotificationContent()
        content.title = "This is my first time notification"
        content.subtitle = "This was sooo easy"
        content.sound = .default
        content.badge  = 1
        
        // Вказує на те, коли буде спрацьовувати повідомлення
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        // Запрос на повідомлення
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
    
    // Повідомлення за календарем
    func calendarNotification() {
        
        // Контент повідомлення, що має мати пункти з options
        let content = UNMutableNotificationContent()
        content.title = "This is my first calendar notification"
        content.subtitle = "This was sooo easy"
        content.sound = .default
        content.badge  = 1
        
        // Налаштування дати
        var dateComponents = DateComponents()
        dateComponents.hour = 20
        dateComponents.minute = 56
        
        // Вказує на те, коли буде спрацьовувати повідомлення
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        // Запрос на повідомлення
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
    
    func locationNotification() {
        
        // Контент повідомлення, що має мати пункти з options
        let content = UNMutableNotificationContent()
        content.title = "This is my first location notification"
        content.subtitle = "This was sooo easy"
        content.sound = .default
        content.badge  = 1
        
        // Координати місця повідомлення
        let coordinates = CLLocationCoordinate2D(
            latitude: 49.880032,
            longitude: 36.289537)
        
        // Регіон з радіусом 100 та центром з координат вище, в межах яких будуть надходити повідомлення
        let region = CLCircularRegion(
            center: coordinates,
            radius: 100,
            identifier: UUID().uuidString)
        
        // Вказує на те, коли буде спрацьовувати повідомлення
        let trigger = UNLocationNotificationTrigger(region: region, repeats: false)
        
        // Запрос на повідомлення
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
    
    // Відміна всіх повідомлень
    func cancelNotification() {
        
        // removeAllPendingNotificationRequests видаляє тільки ті сповіщення, які ще не були виконані.
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        
        // removeAllDeliveredNotifications видаляє тільки ті сповіщення, які вже були відправлені та показані користувачеві.
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
    
}
