//
//  StorageHandler.swift
//  Class_Student_AddApp
//
//  Created by Fredson Silva on 26/01/23.
//

import Foundation

class StorageHandler {
    
    // MARK: - setting Plist file
    static private var plistURL: URL {
        
        // select document's folder
        let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        // creating Plist file on document's folder
        return documents.appendingPathComponent("students.plist")
    }
    
    // MARK: - creating a new student
    static func write(item: Student) {
        if !FileManager.default.fileExists(atPath: plistURL.path) {
            FileManager.default.createFile(atPath: plistURL.path, contents: prepareData([item]), attributes: nil)
            
            print(plistURL.path)
        } else {
            var currentItens = StorageHandler.load()
            currentItens.append(item)
            try? prepareData(currentItens).write(to: plistURL)
        }
    }
    
    // MARK: - To consulting itens
    static func load() -> [Student] {
        let decoder = PropertyListDecoder()
        
        guard let data = try? Data.init(contentsOf: plistURL), let preferences = try? decoder.decode([Student].self, from: data)
            else { return [] }
                
        return preferences
    }
    
    // MARK: - To delete the Plist file
    static func deleteAll() {
        
        if FileManager.default.fileExists(atPath: plistURL.path) {
            
            try? FileManager.default.removeItem(at: plistURL)
            
        }
    }
    
    // MARK: - This method packages data to easely be required and used in a simple way
    static func prepareData(_ value: [Student]) -> Data {
        
        let encoder = PropertyListEncoder()
        
        guard let data = try? encoder.encode(value) else {
            return Data()
        }
        
        return data
    }
}
