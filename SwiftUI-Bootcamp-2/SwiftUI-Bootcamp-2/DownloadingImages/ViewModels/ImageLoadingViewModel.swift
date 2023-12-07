//
//  ImageLoadingViewModel.swift
//  SwiftUI-Bootcamp-2
//
//  Created by Микита Кузьмінов on 07.12.2023.
//

import Foundation
import SwiftUI
import Combine

class ImageLoadingViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    var cancellables = Set<AnyCancellable>()
    
    init(url: String) {
        downloadImage(url: url)
    }
    
    func downloadImage(url: String) {
        
        isLoading = true
        guard let url = URL(string: url) else {
            isLoading = false
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .sink { [weak self] (_) in
                self?.isLoading = false
            } receiveValue: { [weak self] (returnedImage) in
                self?.image = returnedImage
            }
            .store(in: &cancellables)
    }
}
