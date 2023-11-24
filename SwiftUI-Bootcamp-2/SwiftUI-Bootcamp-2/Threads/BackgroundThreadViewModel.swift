//
//  BackgroundThreadViewModel.swift
//  SwiftUI-Bootcamp-2
//
//  Created by Микита Кузьмінов on 24.11.2023.
//

import Foundation

class BackgroundThreadViewModel: ObservableObject {
    
    @Published var data: [String] = []
    
    // Функція, що завантажує дані не на головному потоці та змінює UI
    // Зміна UI відбувається лише на головному потоці
    func fetchData() {
        // Завантаження даних
        DispatchQueue.global(qos: .background).async {
            let newData = self.downloadData()
            
            // Відбувається зміна UI на головному потоці
            DispatchQueue.main.async {
                self.data = newData
            }
        }
    }

    // Функція, що завантажує данні, наприклад з інтернету, або з іншого місця
    private func downloadData() -> [String] {
        var data: [String] = []
        for x in 0..<100 {
            data.append("\(x)")
        }
        return data
    }
}
