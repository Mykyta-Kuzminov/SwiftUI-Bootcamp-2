//
//  EscapingBootcamp.swift
//  SwiftUI-Bootcamp-2
//
//  Created by Микита Кузьмінов on 26.11.2023.
//

import SwiftUI

class EscapingViewModel: ObservableObject {
    
    @Published var title: String = "No data"
    
    // Отримуємо дані з completionHandler та використовємо weak self, тому що створюємо strong reference.
    func getData() {
        downloadData { [weak self] result in
            self?.title = result.data
        }
    }
    
    // Завантажуємо дані асинхронно, використовуючи completionHandler.
    func downloadData(completionHandler: @escaping DownloadCompletion) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            let result = DownloadResult(data: "Data")
            completionHandler(result)
        }
    }
}

struct DownloadResult {
    let data: String
}

typealias DownloadCompletion = (DownloadResult) -> ()

struct EscapingBootcamp: View {
    
    @StateObject var vm = EscapingViewModel()
    
    var body: some View {
        Text(vm.title)
            .font(.title)
            .fontWeight(.semibold)
            .foregroundStyle(.blue)
            .onTapGesture {
                withAnimation {
                    vm.getData()
                }
            }
    }
}

#Preview {
    EscapingBootcamp()
}
