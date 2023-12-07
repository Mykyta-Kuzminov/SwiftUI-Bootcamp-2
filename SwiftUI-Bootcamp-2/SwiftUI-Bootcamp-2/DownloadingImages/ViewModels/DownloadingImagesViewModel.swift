//
//  DownloadingImagesViewModel.swift
//  SwiftUI-Bootcamp-2
//
//  Created by Микита Кузьмінов on 07.12.2023.
//

import Foundation
import Combine

class DownloadingImagesViewModel: ObservableObject {
    
    @Published var dataArray: [PhotoModel] = []
    var cancellables = Set<AnyCancellable>()
    
    let dataService = PhotoModelDataService.instance
    
    init() {
        addSubscriber()
    }
    
    func addSubscriber() {
        dataService.$photoModels
            .sink { [weak self] (returnedPhotoModels) in
                self?.dataArray = returnedPhotoModels
            }
            .store(in: &cancellables)
    }
    
}
