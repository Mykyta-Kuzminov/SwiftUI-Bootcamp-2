//
//  SoundManager.swift
//  SwiftUI-Bootcamp-2
//
//  Created by Микита Кузьмінов on 11.11.2023.
//

import Foundation
import AVKit

class SoundManager {
    
    // Singleton використовуємо для створення лише одного екземпляра класа
    static let instance = SoundManager()
    
    // Створюємо аудіо плеєр
    var player: AVAudioPlayer?
    
    // Функція що грає музику
    func playSound(sound: SoundOption) {
        
        // Створюємо посилання на файл в нашій директорії за допомогою Bundle
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".wav") else { return }
        
        // Так як AVAudioPlayer може повернути помилку, потрібно обробити її за допомогою блоку do-catch
        do {
            // Якщо помилки не буде, виконається код
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            // Якщо буде помилка
            print(error.localizedDescription)
        }
    }
}

// Перечислення для аудіо плеєра
enum SoundOption: String {
    case gameover
    case notification
}
