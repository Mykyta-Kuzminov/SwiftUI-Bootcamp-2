//
//  SubscriberBootcamp.swift
//  SwiftUI-Bootcamp-2
//
//  Created by Микита Кузьмінов on 03.12.2023.
//

import SwiftUI
import Combine

class SubscriberViewModel: ObservableObject {
    
    @Published var count: Int = 0
    @Published var textFieldText: String = ""
    @Published var textIsValid: Bool = false
    @Published var showButoon: Bool = false
    var cancellables = Set<AnyCancellable>()
    
    init() {
        setUpTimer()
        addTextFieldSubscriber()
        addButtonSubscriber()
    }
    
    // Функція-таймер, що постійно надсилає події та використовується у ViewModel
    func setUpTimer() {
        Timer
            .publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
        // Отримуємо події. Використовуємо замість onRecieve.
            .sink { [weak self] _ in
                withAnimation(.default) {
                    guard let self = self else { return }
                    self.count += 1
                    // Відміняє підписки
//                    if self.count >= 20 {
//                        for item in self.cancellables {
//                            item.cancel()
//                        }
//                    }
                }
            }
            // Зберігаємо підписки
            .store(in: &cancellables)
    }
    
    func addTextFieldSubscriber() {
        $textFieldText
            // Встановлює затримку між подіями, щоб не перевіряти постійно.
            .debounce(for: .seconds(0.3), scheduler: DispatchQueue.main)
            .map { (text) -> Bool in
                if text.count < 3 {
                    return false
                }
                return true
            }
            .sink { [weak self] (isValid) in
                withAnimation(.default) {
                    self?.textIsValid = isValid
                }
            }
            .store(in: &cancellables)
    }
    
    func addButtonSubscriber() {
        $textIsValid
            // Об'єднуємо два Publishers, події яких можемо використовувати.
            .combineLatest($count)
            .sink { [weak self] (isValid, count) in
                guard let self = self else { return }
                if isValid && count >= 10 {
                    self.showButoon = true
                } else {
                    self.showButoon = false
                }
            }
            .store(in: &cancellables)
    }
}

struct SubscriberBootcamp: View {
    
    @StateObject var vm = SubscriberViewModel()
    
    var body: some View {
        VStack {
            Text("\(vm.count)")
                .font(.system(size: 100,
                              weight: .semibold,
                              design: .rounded))
            
            TextField("Put some text here...", text: $vm.textFieldText)
                .padding(.horizontal)
                .frame(maxWidth: .infinity)
                .frame(height: 60)
                .background(.gray.opacity(0.3))
                .clipShape(.rect(cornerRadius: 20))
                .overlay {
                    if !vm.textIsValid {
                        Image(systemName: "xmark")
                            .fontWeight(.semibold)
                            .foregroundStyle(.red)
                            .frame(width: 320, alignment: .trailing)
                    } else {
                        Image(systemName: "checkmark")
                            .foregroundStyle(.green)
                            .frame(width: 320, alignment: .trailing)
                    }
                }
            
            Button {
                vm.textFieldText = ""
            } label: {
                Text("Submit".uppercased())
                    .font(.title3)
                    .fontWeight(.semibold)
                    .fontDesign(.rounded)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 60)
                    .background(.blue)
                    .clipShape(.rect(cornerRadius: 20))
                    .opacity(vm.showButoon ? 1.0 : 0.5)
            }
            .disabled(!vm.showButoon)
        }
        .padding()
    }
}

#Preview {
    SubscriberBootcamp()
}
