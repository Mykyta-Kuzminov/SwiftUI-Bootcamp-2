//
//  ArrayBootcamp.swift
//  SwiftUI-Bootcamp-2
//
//  Created by Микита Кузьмінов on 13.11.2023.
//

import SwiftUI

// Модель користувача
struct UserModel: Identifiable {
    let id = UUID().uuidString
    let username: String
    let followers: Int
    let isVerified: Bool
}

// ViewModel користувача
class UserViewModel: ObservableObject {
    
    // Властивості, що змінюються та оновлюють UI
    @Published var data: [UserModel] = []
    @Published var category: ListCategory = .none
    @Published var sortedData: [UserModel] = []
    @Published var filteredData: [UserModel] = []
    
    // Ініціалізація data
    init() {
        data.append(contentsOf: [
            UserModel(username: "Nick", followers: 1024, isVerified: true),
            UserModel(username: "Sara", followers: 768, isVerified: true),
            UserModel(username: "Chris", followers: 331, isVerified: false),
            UserModel(username: "Joe", followers: 2506, isVerified: true),
            UserModel(username: "Jack", followers: 14, isVerified: false),
            UserModel(username: "Merfi", followers: 899, isVerified: true),
            UserModel(username: "Jeremy", followers: 1007, isVerified: true),
            UserModel(username: "Anne", followers: 152, isVerified: false)
        ])
    }
    
    // Видаляє елемент зі списку
    func delete(indexSet: IndexSet) {
        data.remove(atOffsets: indexSet)
    }
    
    // Пересуває елемент у списку
    func move(indices: IndexSet, newOffset: Int ) {
        data.move(fromOffsets: indices, toOffset: newOffset)
    }
    
    // В залежності від категорії повертає дані
    func chooseCategory() -> [UserModel] {
        switch category {
        case .followers:
            data.sorted(by: { $0.followers > $1.followers})
        case .verification:
            data.filter({ $0.isVerified })
        default:
            data
        }
    }
}

// Перечислення категорій для пікеру та ViewModel
enum ListCategory: String, CaseIterable {
    case none = "None"
    case followers = "Followers"
    case verification = "Verification"
}

struct ArrayBootcamp: View {
    
    @StateObject var userVM = UserViewModel()
    
    var body: some View {
        VStack {
            HStack {
                EditButton()
                    .frame(width: 70)
                    .padding(4)
                    .background(Color.gray.opacity(0.2))
                    .clipShape(.rect(cornerRadius: 6))
                    .foregroundStyle(Color.primary)
                
                CategoryPicker(userVM: userVM)
            }
            .padding()
            
            List {
                ForEach(userVM.chooseCategory()) { user in
                    UserView(user: user)
                }
                .onDelete(perform: userVM.delete)
                .onMove(perform: userVM.move)
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            
        }
    }
}

struct UserView: View {
    
    let user: UserModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(user.username)
                    .font(.title)
                    .fontWeight(.semibold)
                Text("Followers: " + "\(user.followers)")
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.gray.opacity(0.8))
            }
            
            Spacer()
            
            Image(systemName: user.isVerified ? "checkmark.seal.fill" : "xmark.seal")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .foregroundStyle(user.isVerified ? Color.green : Color.red)
        }
        .padding(.horizontal)
    }
}

struct CategoryPicker: View {
    
    @ObservedObject var userVM: UserViewModel
    @State var selection: String = "None"
    
    var body: some View {
        Picker(selection: $selection) {
            ForEach(ListCategory.allCases, id: \.rawValue) { item in
                Text(item.rawValue).tag(item.rawValue)
            }
        } label: {
            Text("Category: ")
        }
        .tint(.primary)
        .pickerStyle(.palette)
        .onChange(of: selection) { oldValue, newValue in
            userVM.category = ListCategory(rawValue: newValue) ?? .none
        }
    }
}

#Preview {
    ArrayBootcamp()
}
