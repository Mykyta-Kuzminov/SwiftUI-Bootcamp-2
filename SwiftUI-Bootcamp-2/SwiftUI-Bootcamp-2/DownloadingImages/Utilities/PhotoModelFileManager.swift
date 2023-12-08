//
//  PhotoModelFileManager.swift
//  SwiftUI-Bootcamp-2
//
//  Created by Микита Кузьмінов on 08.12.2023.
//

import Foundation
import SwiftUI

class PhotoModelFileManager {
    
    static let instance = PhotoModelFileManager()
    let folderName = "downloaded_photos"
    
    private init() {
        createFolderIfNeeded()
    }
    
    func add(key: String, image: UIImage) {
        guard
            let data = image.pngData(),
            let path = getImagePath(key: key) else { return }
        
        do {
            try data.write(to: path)
        } catch let error {
            print("Error saving data: \(error)")
        }
    }
    
    func get(key: String) -> UIImage? {
        guard
            let url = getImagePath(key: key),
            FileManager.default.fileExists(atPath: url.path) else { return nil }
        
        return UIImage(contentsOfFile: url.path)
    }
    
    private func createFolderIfNeeded() {
        guard let url = getFolderPath() else { return }
        
        if !FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.createDirectory(atPath: url.path, withIntermediateDirectories: true)
                print("Created folder!")
            } catch let error {
                print("Error creating folder: \(error)")
            }
        }
    }
    
    private func getFolderPath() -> URL? {
        return FileManager
            .default
            .urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
            .appending(component: folderName)
    }
    
    private func getImagePath(key: String) -> URL?{
        guard let folder = getFolderPath() else { return nil }
        
        return folder.appending(component: key + ".png")
    }
    
}
