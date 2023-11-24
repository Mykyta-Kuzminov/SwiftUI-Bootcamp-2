//
//  BackgroundThreadBootcamp.swift
//  SwiftUI-Bootcamp-2
//
//  Created by Микита Кузьмінов on 24.11.2023.
//

import SwiftUI

struct BackgroundThreadBootcamp: View {
    
    @StateObject var vm = BackgroundThreadViewModel()
    
    var body: some View {
        VStack {
            Button {
                withAnimation {
                    vm.fetchData()
                }
            } label: {
                Text("Fetch data")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 60)
                    .background(.blue.opacity(0.7))
                    .clipShape(.rect(cornerRadius: 20))
            }
            ScrollView {
                LazyVStack {
                    ForEach(vm.data, id: \.self) { data in
                        Text(data)
                            .font(.headline)
                            .fontWeight(.semibold)
                    }
                }
            }
            
        }
        .padding()
    }
}

#Preview {
    BackgroundThreadBootcamp()
}
