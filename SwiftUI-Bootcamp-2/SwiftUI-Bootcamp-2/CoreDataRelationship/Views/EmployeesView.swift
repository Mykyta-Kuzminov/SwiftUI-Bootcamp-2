//
//  EmployeesView.swift
//  SwiftUI-Bootcamp-2
//
//  Created by Микита Кузьмінов on 22.11.2023.
//

import SwiftUI

struct EmployeesView: View {
    
    @EnvironmentObject var vm: RelationshipViewModel
    @State var textFieldText: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(vm.employees) { employee in
                            EmployeeLayout(employee: employee)
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
                        vm.addEmployee(
                            name: "Mykyta",
                            surname: "Kuzminov",
                            age: 17)
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
            .navigationTitle("Employees")
        }
    }
}

struct EmployeeLayout: View {
    
    let employee: Employee
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Name:")
                .font(.title3)
                .fontWeight(.semibold)
            HStack(spacing: 3) {
                Text(employee.name ?? "")
                Text(employee.surname ?? "")
            }
            
            Text("Age:")
                .font(.title3)
                .fontWeight(.semibold)
            Text("\(employee.age)")
            
            Text("Business:")
                .font(.title3)
                .fontWeight(.semibold)
            Text(employee.business?.title ?? "")
            
            Text("Departments:")
                .font(.title3)
                .fontWeight(.semibold)
            Text(employee.department?.title ?? "")
            
            
            Spacer()
                
        }
        .frame(width: 150, height: 240, alignment: .leading)
        .padding()
        .background(Color.blue.opacity(0.7))
        .clipShape(.rect(cornerRadius: 20))
    }
}

#Preview {
    EmployeesView()
        .environmentObject(RelationshipViewModel())
}
