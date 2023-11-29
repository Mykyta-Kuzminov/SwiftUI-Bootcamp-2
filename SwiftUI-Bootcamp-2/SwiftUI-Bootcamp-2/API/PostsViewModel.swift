//
//  PostsViewModel.swift
//  SwiftUI-Bootcamp-2
//
//  Created by Микита Кузьмінов on 29.11.2023.
//

import Foundation

class PostsViewModel: ObservableObject {
    
    @Published var posts: [PostModel] = []
    
    init() {
        fetchData()
    }
    
    func fetchData() {
        
        // Створюємо посилання
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        // Використовуємо функцію що завантажує json дані з інтернету
        downloadData(url: url) { data in
            
            // Перевірямо чи існують дані
            if let data = data {
                
                // Обробляємо помилки, що можуть виникнути
                do {
                    
                    // Декодуємо дані
                    let decodedData = try JSONDecoder().decode([PostModel].self, from: data)
                    
                    // Так як, отримані дані нам потрібно помістити у posts, що призведе до зміни UI, то це потрібно робити тільки на main thread
                    DispatchQueue.main.async { [weak self] in
                        self?.posts = decodedData
                    }
                } catch let error {
                    print("Decoding error \(error.localizedDescription)")
                }
            }
        }
    }
    
    // Функція, що отримує json дані з інтернету.
    // URLSession вже за замовчуванням завантажує дані на background thread.
    // Використовуємо @escaping бо дані будуть завантажуватись якийсь час і функція повинна існувати в цей час.
    func downloadData(url: URL, completionHandler: @escaping (_ data: Data?) -> ()) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                let data = data,
                error == nil,
                let response = response as? HTTPURLResponse,
                response.statusCode >= 200 && response.statusCode < 300 else {
                completionHandler(nil)
                return
            }
            
            completionHandler(data)
        }.resume()
    }
}
