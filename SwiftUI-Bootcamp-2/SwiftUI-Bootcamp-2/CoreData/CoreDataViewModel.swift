//
//  CoreDataViewModel.swift
//  SwiftUI-Bootcamp-2
//
//  Created by Микита Кузьмінов on 16.11.2023.
//

import Foundation
import CoreData

class CoreDataViewModel: ObservableObject {
    
    // Створюємо контейнер
    let container: NSPersistentContainer
    
    @Published var data: [User] = []
    
    init() {
        // Зв'язуємо наш контейнер з моделлю даних
        container = NSPersistentContainer(name: "DataModel")
        
        // Завантажуємо дані зі сховища в контейнер
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("Loading error: \(error.localizedDescription)")
            }
        }
        
        fetchUsers()
    }
    
    // Достаємо дані з контейнеру
    func fetchUsers() {
        let request = NSFetchRequest<User>(entityName: "User")
        
        do {
            data = try container.viewContext.fetch(request)
        } catch let error {
            print("Fetching error: \(error.localizedDescription)")
        }
    }
    
    // Дадоємо нові дані до контейнеру
    func addUser(name: String) {
        let newUser = User(context: container.viewContext)
        newUser.name = name
        
        saveUsers()
    }
    
    // Видаляємо дані з контейнеру
    func deleteUser(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let entity = data[index]
        container.viewContext.delete(entity)
        
        saveUsers()
    }
    
    // Змінюємо дані
    func updateUser(user: User) {
        let currentName = user.name ?? ""
        let newName = currentName + "!"
        user.name = newName
        
        saveUsers()
    }
    
    // Зберігаємо зміни
    func saveUsers() {
        do {
            try container.viewContext.save()
        } catch let error {
            print("Saving error: \(error.localizedDescription)")
        }
        
        fetchUsers()
    }
}
