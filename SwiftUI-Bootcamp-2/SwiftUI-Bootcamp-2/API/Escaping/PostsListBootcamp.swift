//
//  PostsListBootcamp.swift
//  SwiftUI-Bootcamp-2
//
//  Created by Микита Кузьмінов on 29.11.2023.
//

import SwiftUI

struct PostsListBootcamp: View {
    
    @StateObject var vm = PostsViewModel()
    
    var body: some View {
        ScrollView {
            ForEach(vm.posts) { post in
                VStack(alignment: .leading) {
                    Text(post.title)
                        .font(.title3)
                        .fontWeight(.semibold)
                    
                    Text(post.body)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: 200)
                .padding(.horizontal)
            }
        }
    }
}

#Preview {
    PostsListBootcamp()
}
