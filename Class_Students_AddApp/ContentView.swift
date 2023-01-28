//
//  ContentView.swift
//  Class_Student_AddApp
//
//  Created by Fredson Silva on 26/01/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = ContentViewModel()
    
    var body: some View {
    
            NavigationView {
                Form {
                    Section(header: Text("Registration")) {
                        InsertStudentView()
                    }
                    Section(header: Text("Registered Students")) {
                        StudentsListView()
                    }
                    HStack {
                        Spacer()
                        Savebutton()
                        Spacer()
                        Deletebutton()
                        Spacer()
                    }
                }
                .navigationTitle("Register Students")
                
            }
            .environmentObject(viewModel)
            .onAppear {
                viewModel.updateStudent() // to load data from Plist whenever it have data there
            }
    }
}

// MARK: - Insert student
struct InsertStudentView: View {
    
    @EnvironmentObject var viewModel: ContentViewModel
    
    var body: some View {
        HStack {
            Label("Name:", systemImage: "person")
                //.foregroundColor(.black)
            TextField("Type here", text: $viewModel.newStudent.name)
        }
        
        HStack {
            Label("Age:", systemImage: "figure.and.child.holdinghands")
                //.foregroundColor(.black)
            TextField("Type here", text: $viewModel.newStudent.age)
 
        }
    }
}


//MARK: - Students list

struct StudentsListView: View {
    
    @EnvironmentObject var viewModel: ContentViewModel
    
    var body: some View {
        
        ForEach(viewModel.registeredStudents) { student in
            HStack {
//                Image(systemName: "person.text.rectangle")
//                    .foregroundColor(.blue)
                VStack(alignment: .leading) {
                    
                    VStack {
                        Text("")
                        + Text("Name: ")
                            .foregroundColor(Color.gray)
                        + Text("\(student.name)")
                    }
                    
                    VStack {
                        Text("")
                        + Text("Age: ")
                            .foregroundColor(Color.gray)
                        + Text("\(student.age) years old")
                    }
                    
                }
            }
            //.foregroundColor(.gray)
        }
        
    }
}


//MARK: - Delete buton
struct Deletebutton: View {
    
    @EnvironmentObject var viewModel: ContentViewModel
    
    var body: some View {
        HStack {

            // clear registered Student
            Button {viewModel.resetRegisteredStudents()} label: {
                Label("Delete All", systemImage: "folder.badge.minus")
                    .foregroundColor(.red)
            }
            .disabled(viewModel.registeredStudents.isEmpty)
            .buttonStyle(.borderless)
        }
    }
}

// MARK: - Save button
struct Savebutton: View {
    
    @EnvironmentObject var viewModel: ContentViewModel
    
    var body: some View {
        HStack {
            // to save
            Button{viewModel.creatStudent()} label: {
                
                Label("Save", systemImage: "square.and.arrow.down.on.square")
                    .foregroundColor(.blue)
            }
            .disabled(viewModel.newStudent.name.isEmpty || viewModel.newStudent.age.isEmpty)
            .buttonStyle(.borderless)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
