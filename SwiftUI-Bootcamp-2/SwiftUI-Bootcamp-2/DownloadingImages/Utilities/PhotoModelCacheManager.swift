//
//  PhotoModelCacheManager.swift
//  SwiftUI-Bootcamp-2
//
//  Created by Микита Кузьмінов on 08.12.2023.
//

import Foundation
import SwiftUI

class PhotoModelCacheManager {
    
    static let instance = PhotoModelCacheManager()
    
    private init() { }
    
    var imageCache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.countLimit = 200
        cache.totalCostLimit = 1024 * 1024 * 200
        return cache
    }()
    
    func add(key: String, image: UIImage) {
        imageCache.setObject(image, forKey: key as NSString)
    }
    
    func get(key: String) -> UIImage? {
        guard 
            let returnedImage = imageCache.object(forKey: key as NSString) else {
            return nil
        }
        return returnedImage
    }
}
