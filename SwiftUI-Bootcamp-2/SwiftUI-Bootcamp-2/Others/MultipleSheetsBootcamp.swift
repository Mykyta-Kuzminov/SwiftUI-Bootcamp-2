//
//  MultipleSheetsBootcamp.swift
//  SwiftUI-Bootcamp-2
//
//  Created by Микита Кузьмінов on 10.11.2023.
//

import SwiftUI

/*
 Є декілька варіантів, як зробити багато sheets у вашому додатку.
 1 - Використовувати @Bidning. Можна роботи, але іноді @Binding буде заважати, або його не можливо буде використовувати.
 
 2 - Використовувати багато .sheet, але в одній ієрархії. Цей варіант не дуже гарний, бо постійно потрібно повторювати код.
 
 3 - Використовувати .sheet(item: , content: ). В параметр item потрібно передавати змінну, що має тип данних підписаний на протокол Identifiable. При зміні цієї змінної будуть з'являтися sheets. Для цього способу не потрібно багато коду.
 */

struct SheetModel: Identifiable {
    var id: String = UUID().uuidString
    let title: String
}

struct MultipleSheetsBootcamp: View {
    
    @State var currentSheet: SheetModel?
    
    var body: some View {
        VStack {
            ForEach(1..<10) { index in
                Button {
                    currentSheet = SheetModel(title: "\(index)")
                } label: {
                    Text("Button №\(index)")
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .sheet(item: $currentSheet) { sheet in
            SheetView(sheet: sheet)
        }
    }
}

struct SheetView: View {
    
    let sheet: SheetModel
    
    var body: some View {
        Text(sheet.title)
            .font(.title)
            .fontWeight(.semibold)
    }
}

#Preview {
    MultipleSheetsBootcamp()
}
