//
//  NSCacheBootcamp.swift
//  SwiftUI-Bootcamp-2
//
//  Created by Микита Кузьмінов on 06.12.2023.
//

import SwiftUI

class NSCacheManager: ObservableObject {
    
    static let instance = NSCacheManager()
    
    private init() {}
    
    var imageCache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        
        // Встановлює максимальну кількість об'єктів, яку може містити кеш. У цьому випадку вона встановлена на 100, що означає, що кеш видалятиме найдавніші елементи, якщо досягнута максимальна кількість.
        cache.countLimit = 100
        
        // Встановлює максимальний обсяг пам'яті, який кеш може використовувати. У цьому випадку обсяг обмежений значенням 1024 * 1024 * 100, що означає 100 мегабайт.
        cache.totalCostLimit = 1024 * 1024 * 100
        return cache
    }()
    
    // Фкнція, що додає зображення в кеш
    func add(image: UIImage, name: String) -> String {
        imageCache.setObject(image, forKey: name as NSString)
        return "Added to Cache"
    }
    
    // Функція, що видаляє зображенння з кешу
    func remove(name: String) -> String {
        imageCache.removeObject(forKey: name as NSString)
        return "Removed from Cache"
    }
    
    // Функція, що отримує і повертає зображення з кешу
    func get(name: String) -> UIImage? {
        return imageCache.object(forKey: name as NSString)
    }
}

class NSCacheViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var cachedImage: UIImage? = nil
    @Published var message: String = ""
    let imageName: String = "minecraft"
    let manager = NSCacheManager.instance
    
    init() {
        getImageFromAssets()
    }
    
    func getImageFromAssets() {
        image = UIImage(named: imageName)
    }
    
    func saveImageToCache() {
        guard let image = image else { return }
        message = manager.add(image: image, name: imageName)
    }
    
    func removeImageFromCache() {
        message = manager.remove(name: imageName)
    }
    
    func getImageFromCache() {
        if let returnedImage = manager.get(name: imageName) {
            cachedImage = returnedImage
            message = "Got image from Cache"
        } else {
            message = "Image not found in Cache"
        }
    }
}

struct NSCacheBootcamp: View {
    
    @StateObject var vm = NSCacheViewModel()
    
    var body: some View {
        VStack {
            
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 200, height: 200)
                    .clipShape(.rect(cornerRadius: 30))
            }
            
            HStack {
                Button {
                    vm.saveImageToCache()
                } label: {
                    Text("Save to Cache")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .padding(7)
                        .background(.blue)
                        .clipShape(.rect(cornerRadius: 10))
                }
                
                Button {
                    vm.removeImageFromCache()
                } label: {
                    Text("Delete from Cache")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .padding(7)
                        .background(.red)
                        .clipShape(.rect(cornerRadius: 10))
                }
            }
            
            Button {
                vm.getImageFromCache()
            } label: {
                Text("Get from Cache")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .padding(7)
                    .background(.green)
                    .clipShape(.rect(cornerRadius: 10))
            }
            
            if let image = vm.cachedImage {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 200, height: 200)
                    .clipShape(.rect(cornerRadius: 30))
            }
            
            Text(vm.message)
                .font(.title)
                .fontWeight(.semibold)
                .foregroundStyle(.purple)
        }
    }
}

#Preview {
    NSCacheBootcamp()
}
