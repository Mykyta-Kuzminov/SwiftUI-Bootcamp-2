//
//  CodableBootcamp.swift
//  SwiftUI-Bootcamp-2
//
//  Created by Микита Кузьмінов on 27.11.2023.
//

import SwiftUI

struct PersonModel: Identifiable, Codable {
    var id: String = UUID().uuidString
    let username: String
    let password: String
}

class PersonViewModel: ObservableObject {
    
    @Published var users: [PersonModel] = []
    
    init() {
        decodeData()
    }
    
    // Декодуємо дані з json
    func decodeData() {
        
        // Обробляємо помилки під час декодування
        do {
            
            // Перевіряємо чи існують json дані
            guard let jsonData = encodeData() else { return }
            let decoder = JSONDecoder()
            
            // Декодуємо
            let data = try decoder.decode([PersonModel].self, from: jsonData)
            users = data
        } catch let error {
            print("Decoding error: \(error.localizedDescription)")
        }
    }
    
    // Кодуємо дані у json
    func encodeData() -> Data? {
        
        // Тестові дані
        let data = [
            PersonModel(username: "petro123", password: "1Hgd901"),
            PersonModel(username: "andrew123", password: "7hJJfh"),
            PersonModel(username: "nick443", password: "KIIO031fd")
        ]
        
        let encoder = JSONEncoder()
        
        // Обробляємо помилки під час кодування
        do {
            
            // Кодуємо
            let jsonData = try encoder.encode(data)
            return jsonData
        } catch let error {
            print("Encoding error: \(error.localizedDescription)")
            return nil
        }
    }
}

struct CodableBootcamp: View {
    
    @StateObject var vm = PersonViewModel()
    
    var body: some View {
        ScrollView {
            ForEach(vm.users) { user in
                VStack(alignment: .leading) {
                    Text(user.username)
                    Text(user.password)
                }
                .font(.title3)
                .fontWeight(.semibold)
                .padding(.vertical)
                .frame(width: 120, height: 100)
                .background {
                    Color.green
                }
                .clipShape(.rect(cornerRadius: 30))
            }
        }
    }
}

#Preview {
    CodableBootcamp()
}
