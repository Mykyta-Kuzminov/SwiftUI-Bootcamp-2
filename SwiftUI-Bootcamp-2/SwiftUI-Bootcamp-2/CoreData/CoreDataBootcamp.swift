//
//  CoreDataBootcamp.swift
//  SwiftUI-Bootcamp-2
//
//  Created by Микита Кузьмінов on 16.11.2023.
//

import SwiftUI

struct CoreDataBootcamp: View {
    
    @StateObject var vm = CoreDataViewModel()
    @State var textFieldText: String = ""
    
    var body: some View {
        VStack {
            TextField("Your name here...", text: $textFieldText)
                .fontWeight(.semibold)
                .padding(.horizontal)
                .frame(height: 60)
                .frame(maxWidth: .infinity)
                .background(.thinMaterial)
                .clipShape(.rect(cornerRadius: 10))
            
            Button {
                vm.addUser(name: textFieldText)
                textFieldText = ""
            } label: {
                Text("Save".uppercased())
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .padding(.horizontal)
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
                    .background(.blue)
                    .clipShape(.rect(cornerRadius: 10))
                
            }
            
            List {
                Section {
                    ForEach(vm.data) { user in
                        Text(user.name ?? "")
                            .onTapGesture {
                                withAnimation {
                                    vm.updateUser(user: user)
                                }
                            }
                    }
                    .onDelete(perform: vm.deleteUser)
                } header: {
                    Text("Users")
                }
            }
            .listStyle(.sidebar)
            .clipShape(.rect(cornerRadius: 30))
        }
        .padding()
    }
}

#Preview {
    CoreDataBootcamp()
}
