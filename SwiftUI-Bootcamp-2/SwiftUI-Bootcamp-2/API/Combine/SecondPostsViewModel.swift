//
//  SecondPostsViewModel.swift
//  SwiftUI-Bootcamp-2
//
//  Created by Микита Кузьмінов on 30.11.2023.
//

import Foundation
import Combine

class SecondPostsViewModel: ObservableObject {
    
    @Published var posts: [PostModel] = []
    var cancellables = Set<AnyCancellable>()
    
    init() {
        fetchData()
    }
    
    // Функція що отримує дані
    func fetchData() {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        /*
         1. subscribe - Мережевий запит буде виконуватися на не головну потоці. DataTaskPublisher вже за замовчуванням робить запит з background, тому цей рядок коду не завжди потрібно писати.
         2. receive - Вказуємо, де буде виконуватися подальша обробка даних, коли ми їх отримаємо.
         3. tryMap - Спроба отримати json дані з обробкою статусу кода
         4. decode - Декодуємо дані
         5. sink - Спроба отримати дані та вивід статусу
         6. store - Зберігання підписок після запитів
         */
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(handlerOutput)
            .decode(type: [PostModel].self, decoder: JSONDecoder())
            .sink { (completion) in
                switch completion {
                case .finished:
                    print("Finished")
                case .failure(let error):
                    print("There was an error: \(error)")
                }
            } receiveValue: { [weak self] returnedData in
                self?.posts = returnedData
            }
            .store(in: &cancellables)
    }
    
    // Функція для обробки відповіді
    func handlerOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard
            let response = output.response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else {
            throw URLError(.badServerResponse)
        }
        return output.data
    }
}
