//
//  AlignmentGuidesBootcamp.swift
//  SwiftUI-Bootcamp-2
//
//  Created by Микита Кузьмінов on 12.12.2023.
//

import SwiftUI

struct AlignmentGuidesBootcamp: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            row(title: "Row 1", showIcon: false)
            row(title: "Row 2", showIcon: true)
            row(title: "Row 3", showIcon: false)
        }
        .padding(16)
        .background(Color.white)
        .clipShape(.rect(cornerRadius: 10))
        .shadow(radius: 10)
        .padding(40)
    }
    
    private func row(title: String, showIcon: Bool) -> some View {
        HStack(spacing: 10) {
            if showIcon {
                Image(systemName: "info.circle")
                    .frame(width: 30, height: 30)
            }
            
            Text(title)
            
            Spacer()
        }
        // Модифікатор за допомогою якого можна вирівнювати елементи зображення
        .alignmentGuide(HorizontalAlignment.leading) { dimension in
            return showIcon ? 0 : -40
        }
    }
}

#Preview {
    AlignmentGuidesBootcamp()
}
