//
//  SwiftUI_Bootcamp_2App.swift
//  SwiftUI-Bootcamp-2
//
//  Created by Микита Кузьмінов on 06.11.2023.
//

import SwiftUI

@main
struct SwiftUI_Bootcamp_2App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            HapticsBootcamp()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
