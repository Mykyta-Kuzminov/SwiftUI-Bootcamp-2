//
//  RelationshipViewModel.swift
//  SwiftUI-Bootcamp-2
//
//  Created by Микита Кузьмінов on 21.11.2023.
//

import Foundation
import CoreData

class RelationshipViewModel: ObservableObject {
    
    @Published var businesses: [Business] = []
    @Published var departments: [Department] = []
    @Published var employees: [Employee] = []
    
    let manager = CoreDataManager()
    
    init() {
        getBusinesses()
        getDepartments()
        getEmployees()
    }
    
    func getBusinesses() {
        let request = NSFetchRequest<Business>(entityName: "Business")
        do {
            businesses = try manager.context.fetch(request)
        } catch let error {
            print("Getting data error: \(error.localizedDescription)")
        }
    }
    
    func getDepartments() {
        let request = NSFetchRequest<Department>(entityName: "Department")
        do {
            departments = try manager.context.fetch(request)
        } catch let error {
            print("Getting data error: \(error.localizedDescription)")
        }
    }
    
    func getEmployees() {
        let request = NSFetchRequest<Employee>(entityName: "Employee")
        do {
            employees = try manager.context.fetch(request)
        } catch let error {
            print("Getting data error: \(error.localizedDescription)")
        }
    }
    
    func addBusiness(title: String) {
        let newBusiness = Business(context: manager.context)
        newBusiness.title = title
        
        newBusiness.departments = [departments[0]]
        newBusiness.employees = [employees[1], employees[2]]
        
        saveData()
    }
    
    func addDepartment(title: String) {
        let newDepartment = Department(context: manager.context)
        newDepartment.title = title
        
        newDepartment.businesses = [businesses[0], businesses[2]]
        newDepartment.employees = []
        
        saveData()
    }
    
    func addEmployee(name: String, surname: String, age: Int16) {
        let newEmployee = Employee(context: manager.context)
        newEmployee.name = name
        newEmployee.surname = surname
        newEmployee.age = age
        
        newEmployee.business = businesses[3]
        newEmployee.department = departments[1]
        
        saveData()
    }
    
    func saveData() {
        manager.saveData()
        getBusinesses()
        getDepartments()
        getEmployees()
    }
}
