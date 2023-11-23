//
//  CoreDataRelationship.swift
//  SwiftUI-Bootcamp-2
//
//  Created by Микита Кузьмінов on 21.11.2023.
//

import SwiftUI

struct CoreDataRelationship: View {
    var body: some View {
        TabView {
            BusinessesView()
                .tabItem {
                    Label("Businesses", systemImage: "bitcoinsign.square")
                }
            
            DepartmentsView()
                .tabItem {
                    Label("Departments", systemImage: "rotate.3d.fill")
                }
            
            EmployeesView()
                .tabItem {
                    Label("Employees", systemImage: "person.fill")
                }
        }
        .tint(Color.cyan)
    }
}

#Preview {
    CoreDataRelationship()
        .environmentObject(RelationshipViewModel())
}
