//
//  WeakSelfViewModel.swift
//  SwiftUI-Bootcamp-2
//
//  Created by Микита Кузьмінов on 25.11.2023.
//

import Foundation

class WeakSelfViewModel: ObservableObject {
    
    @Published var data: String? = nil
    
    init() {
        print("Initialize")
        getData()
    }
    
    deinit {
        print("Deinitialize")
    }
    
    func getData() {
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 500) { [weak self] in
            self?.data = "Got data"
        }
    }
    
}
