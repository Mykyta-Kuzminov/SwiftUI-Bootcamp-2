//
//  HashableBootcamp.swift
//  SwiftUI-Bootcamp-2
//
//  Created by Микита Кузьмінов on 13.11.2023.
//

import SwiftUI

/* 
 Модель, що підписана на протокол Hashable. Кожен екземпляр цієї структури має свій hash, що визначаэться за двома властивостями title та id.
 Якщо id та title у двох екземплярах будуть однакові, то тоді і hash буде однаковий. Якщо вони будуть відрізнятися тільки title або id - hash буде різним.
 Замість Hashable можна використовувати протокол Identifiable. Тоді в ForEach не потрібно буде вказувати id.
*/
struct MyCustomModel: Hashable {
    let id: String
    let title: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title + id)
    }
}
 
struct HashableBootcamp: View {
    
    let data = [
        MyCustomModel(id: "1", title: "One"),
        MyCustomModel(id: "2", title: "Two"),
        MyCustomModel(id: "2", title: "One"),
        MyCustomModel(id: "3", title: "Three")
    ]
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(data, id: \.hashValue) { item in
                    VStack {
                        Text(item.title)
                        Text("\(item.hashValue)")
                    }
                }
            }
        }
    }
}

#Preview {
    HashableBootcamp()
}
