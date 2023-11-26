//
//  TypealiesBootcamp.swift
//  SwiftUI-Bootcamp-2
//
//  Created by Микита Кузьмінов on 26.11.2023.
//

import SwiftUI

struct ContentModel: Identifiable {
    let id: String = UUID().uuidString
    var title: String
    var director: String
    var prefer: Int
}

// Змінює назву існуючого типу даних, який потім можна використати
typealias Film = ContentModel
typealias Cartoon = ContentModel
typealias Serial = ContentModel
typealias TVShow = ContentModel

class TypealiesViewModel: ObservableObject {
    
    @Published var data: [ContentModel] = [
        Film(title: "Film", director: "John", prefer: 100),
        Cartoon(title: "Cartoon", director: "Saul", prefer: 300),
        Serial(title: "Serial", director: "Ben", prefer: 600),
        TVShow(title: "TVShow", director: "Bob", prefer: 300)
    ]
    
}

struct TypealiesBootcamp: View {
    
//    let film = Film(title: "Film", director: "John", prefer: 100)
//    let cartoon = Cartoon(title: "Cartoon", director: "Saul", prefer: 300)
//    let serial = Serial(title: "Serial", director: "Ben", prefer: 600)
//    let tvshow = TVShow(title: "TVShow", director: "Bob", prefer: 300)
    
    @StateObject var vm = TypealiesViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            ForEach(vm.data) { item in
                VStack() {
                    Text(item.title)
                    Text(item.director)
                    Text("\(item.prefer)")
                }
                .frame(width: 100, height: 100)
                .background {
                    Color.cyan
                }
                .clipShape(.rect(cornerRadius: 20))
            }
        }
    }
}

#Preview {
    TypealiesBootcamp()
}
