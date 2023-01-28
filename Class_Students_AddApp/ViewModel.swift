//
//  ViewModel.swift
//  Class_Student_AddApp
//
//  Created by Fredson Silva on 26/01/23.
//

import SwiftUI

class ContentViewModel: ObservableObject {
    
    @Published var newStudent = Student()
    @Published var registeredStudents: [Student] = []
    
    func creatStudent() {
        
        // to creat Plist file and add a new student
        StorageHandler.write(item: newStudent)
        
        // clear data
        newStudent = Student()
        
        // update the array's data
        updateStudent()
    }
    
    func updateStudent() {
        
        // to load existent itens storaged on Plist
        registeredStudents = StorageHandler.load()
    }
    
    func resetRegisteredStudents() {
        StorageHandler.deleteAll()
        
        registeredStudents = StorageHandler.load()
    }
}

