//
//  BusinessView.swift
//  SwiftUI-Bootcamp-2
//
//  Created by Микита Кузьмінов on 21.11.2023.
//

import SwiftUI

struct BusinessesView: View {
    
    @EnvironmentObject var vm: RelationshipViewModel
    @State var textFieldText: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(vm.businesses) { business in
                            BusinessLayout(business: business)
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
                        vm.addBusiness(title: textFieldText)
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
            .navigationTitle("Businesses")
        }
    }
}

struct BusinessLayout: View {
    
    let business: Business
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Business:")
                .font(.title3)
                .fontWeight(.semibold)
            Text(business.title ?? "")
            
            if let departments = business.departments?.allObjects as? [Department] {
                Text("Departments: ")
                    .font(.title3)
                    .fontWeight(.semibold)
                ForEach(departments) { department in
                    Text(department.title ?? "")
                }
            }
            
            Spacer()
                
        }
        .frame(width: 150, height: 240, alignment: .leading)
        .padding()
        .background(Color.green.opacity(0.7))
        .clipShape(.rect(cornerRadius: 20))
    }
}

#Preview {
    BusinessesView()
        .environmentObject(RelationshipViewModel())
}
