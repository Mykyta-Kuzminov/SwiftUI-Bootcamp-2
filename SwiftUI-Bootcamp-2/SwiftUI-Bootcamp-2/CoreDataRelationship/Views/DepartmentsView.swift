//
//  DepartmentsView.swift
//  SwiftUI-Bootcamp-2
//
//  Created by Микита Кузьмінов on 22.11.2023.
//

import SwiftUI

struct DepartmentsView: View {
    
    @EnvironmentObject var vm: RelationshipViewModel
    @State var textFieldText: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(vm.departments) { department in
                            DepartmentLayout(department: department)
                        }
                    }
                }
                .scrollIndicators(.hidden)
                
                Spacer()
                
                TextField("Business title here...", text: $textFieldText)
                    .fontWeight(.semibold)
                    .padding(.horizontal)
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
                    .background(.thinMaterial)
                    .clipShape(.rect(cornerRadius: 20))
                
                Button {
                    withAnimation {
                        vm.addDepartment(title: textFieldText)
                    }
                    
                    textFieldText = ""
                } label: {
                    Text("Save")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .frame(height: 60)
                        .frame(maxWidth: .infinity)
                        .background(.blue)
                        .clipShape(.rect(cornerRadius: 20))
                }
            }
            .padding()
            .navigationTitle("Departments")
        }
    }
}

struct DepartmentLayout: View {
    
    let department: Department
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Name:")
                .font(.title3)
                .fontWeight(.semibold)
            Text(department.title ?? "")
            
            if let businesses = department.businesses?.allObjects as? [Business] {
                Text("Businesses:")
                    .font(.title3)
                    .fontWeight(.semibold)
                ForEach(businesses) { business in
                    Text(business.title ?? "")
                }
            }
            
            if let employees = department.employees?.allObjects as? [Employee] {
                Text("Employees:")
                    .font(.title3)
                    .fontWeight(.semibold)
                ForEach(employees) { employee in
                    HStack(spacing: 3) {
                        Text(employee.name ?? "")
                        Text(employee.surname ?? "")
                    }
                }
            }
            
            Spacer()
                
        }
        .frame(width: 150, height: 240, alignment: .leading)
        .padding()
        .background(Color.blue.opacity(0.7))
        .clipShape(.rect(cornerRadius: 20))
    }
}

#Preview {
    DepartmentsView()
        .environmentObject(RelationshipViewModel())
}
