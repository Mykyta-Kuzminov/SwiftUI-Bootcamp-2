//
//  WeakSelfBootcamp.swift
//  SwiftUI-Bootcamp-2
//
//  Created by Микита Кузьмінов on 25.11.2023.
//

import SwiftUI

struct WeakSelfBootcamp: View {
    var body: some View {
        NavigationStack {
            NavigationLink("Navigate") {
                WeakSelfView()
            }
        }
    }
}

struct WeakSelfView: View {
    
    @StateObject var vm = WeakSelfViewModel()
    
    var body: some View {
        Text(vm.data ?? "")
    }
}

#Preview {
    WeakSelfBootcamp()
}
