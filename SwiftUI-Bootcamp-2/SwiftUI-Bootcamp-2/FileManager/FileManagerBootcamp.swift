//
//  FileManagerBootcamp.swift
//  SwiftUI-Bootcamp-2
//
//  Created by Микита Кузьмінов on 05.12.2023.
//

import SwiftUI

class LocalFileManager {
    
    static let instance = LocalFileManager()
    let folderName = "MyApp_Images"
    
    // При ініціалізації створюється папка, якщо її немає.
    init() {
        createFolderIfNeeded()
    }
    
    // Функція, що створює папку. Для цього нам потрібно мати шлях, де створювати папку та її назву. Після чого, якщо папки немає, то вона створюється FileManager'ом. Якщо папка існує, то нічого не відбувається.
    func createFolderIfNeeded() {
        guard let path = FileManager
            .default
            .urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
            .appending(component: folderName)
            .path
        else {
            return
        }
        
        if !FileManager.default.fileExists(atPath: path) {
            do {
                try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
                print("Success creating folder")
            } catch let error {
                print("Error creating folder: \(error)")
            }
        }
    }
    
    // Функція, що зберігає зображення. Для цього потрібно мати дані та шлях, дез зберігати.
    func saveImage(image: UIImage, name: String) -> String {
        
        guard 
            let data = image.pngData(),
            let path = getPathForImage(name: name)
        else {
            return "Error getting data or path."
        }
        
        do {
            try data.write(to: path)
            return "Success saving!"
        } catch let error {
            return "Error saving. \(error)"
        }
    }
    
    // Функція, що дозволяє нам отримати зображення. Для цього потрібно мати шляї та назву зображення.
    func getImage(name: String) -> UIImage? {
        
        guard
            let path = getPathForImage(name: name)?.path,
            FileManager.default.fileExists(atPath: path)
        else {
            print("Error getting path")
            return nil
        }
        
        return UIImage(contentsOfFile: path)
    }
    
    // Функція що повертає шлях зображення з нової папки.
    func getPathForImage(name: String) -> URL? {
        
        guard let path = FileManager
            .default
            .urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
            .appending(component: folderName)
            .appending(component: "\(name).png")
        else {
            print("Error getting path")
            return nil
        }
        
        return path
    }
    
    // Функція, що видаляє зображення. Для цього потрібен шлях до файлу та його перевірку на існування. Якщо файл існує, то видаляємо його за тим самим шляхом.
    func deleteImage(name: String) -> String {
        
        guard
            let path = getPathForImage(name: name)?.path,
            FileManager.default.fileExists(atPath: path)
        else {
            return "Error getting path"
        }
        
        do {
            try FileManager.default.removeItem(atPath: path)
            return "Success removing!"
        } catch let error {
            return "Error deleting image: \(error)"
        }
    }
    
    // Функція, що видаляє папку. Для цього потрібен шлях до неї.
    func deleteFolder() {
        guard let path = FileManager
            .default
            .urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
            .appending(component: folderName)
            .path
        else {
            return
        }
        
        do {
            try FileManager.default.removeItem(atPath: path)
            print("Success deleting folder.")
        } catch let error {
            print("Error deleting folder: \(error)")
        }
    }
}

class FileManagerViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var infoMessage: String = ""
    let imageName: String = "minecraft"
    let manager = LocalFileManager.instance
    
    init() {
//        getImageFromAssets()
        getImageFromFM()
    }
    
    func getImageFromAssets() {
        image = UIImage(named: imageName)
    }
    
    func getImageFromFM() {
        image = manager.getImage(name: imageName)
    }
    
    func saveImage() {
        guard let image = image else { return }
        infoMessage = manager.saveImage(image: image, name: imageName)
    }
    
    func deleteImage() {
        infoMessage = manager.deleteImage(name: imageName)
        manager.deleteFolder()
    }
    
}

struct FileManagerBootcamp: View {
    
    @StateObject var vm = FileManagerViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                if let image = vm.image {
                    Image(uiImage: image)
                        .resizable()
                        .frame(width: 200, height: 200)
                        .clipShape(.rect(cornerRadius: 30))
                }
                
                HStack {
                    Button {
                        vm.saveImage()
                    } label: {
                        Text("Save to FM")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .fontDesign(.rounded)
                            .foregroundStyle(.white)
                            .frame(height: 60)
                            .padding(.horizontal)
                            .background(.blue)
                            .clipShape(.rect(cornerRadius: 20))
                    }
                    
                    Button {
                        vm.deleteImage()
                    } label: {
                        Text("Delete from FM")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .fontDesign(.rounded)
                            .foregroundStyle(.white)
                            .frame(height: 60)
                            .padding(.horizontal)
                            .background(.red)
                            .clipShape(.rect(cornerRadius: 20))
                    }
                }
                
                Text(vm.infoMessage)
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundStyle(.purple)
                
                Spacer()
            }
            .navigationTitle("Minecraft Image")
        }
    }
}

#Preview {
    FileManagerBootcamp()
}
