//
//  SecondPostsViewBootcamp.swift
//  SwiftUI-Bootcamp-2
//
//  Created by Микита Кузьмінов on 30.11.2023.
//

import SwiftUI

struct SecondPostsViewBootcamp: View {
    
    @StateObject var vm = SecondPostsViewModel()
    
    var body: some View {
        ScrollView {
            ForEach(vm.posts) { post in
                VStack(alignment: .leading) {
                    Text(post.title)
                        .fontWeight(.semibold)
                    Text(post.body)
                    Divider()
                }
                .padding(.horizontal)
            }
        }
    }
}

#Preview {
    SecondPostsViewBootcamp()
}
