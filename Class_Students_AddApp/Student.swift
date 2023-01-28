//
//  Student.swift
//  Class_Student_AddApp
//
//  Created by Fredson Silva on 26/01/23.
//

import Foundation

struct Student: Codable, Identifiable {
    var id = UUID()
    var name: String = ""
    var age: String = ""
//    var grade: Int = 0
//    var score: Double = 0.0
}
