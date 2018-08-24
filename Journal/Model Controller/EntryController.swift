//
//  EntryController.swift
//  Journal
//
//  Created by John Tate on 8/22/18.
//  Copyright © 2018 John Tate. All rights reserved.
//

import Foundation

class EntryController {
    
    // Prevents two instances from reaching your variables and methods.  It creates ONLY ONE instance to give you access to its instance methods and variables.
    static let shared = EntryController()
    
    // SOURCE OF TRUTH
    var entries: [Entry] = []
        
    // Create
    func addEntryWith(title: String, bodytext: String) {
        let newEntry = Entry(timestamp: Date(), title: title, bodytext: bodytext)
        entries.append(newEntry)
        saveToPersistentStore()
    }
    
    // Remove
    func remove(entryToDelete: Entry) {
        guard let index = entries.index(of: entryToDelete) else { return }
        entries.remove(at: index)
        saveToPersistentStore()
    }
    
    // Update
    func update(entryToUpdate: Entry, newTitle: String, newBodyText: String) {
        entryToUpdate.timestamp = Date()
        entryToUpdate.title = newTitle
        entryToUpdate.bodytext = newBodyText
        saveToPersistentStore()
    }
 
    // MARK - Persistence
    
    private func fileURL() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileName = "journal.json"
        let documentsDirectoryURL = urls[0].appendingPathComponent(fileName)
        return documentsDirectoryURL
    }
    
    func saveToPersistentStore() {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(entries)
            print(data)
            try data.write(to: fileURL())
        } catch {
            print("There was an error Saving to Persistent Store \(error) \(error.localizedDescription)")
        }
    }
    
    func loadFromPersistentStore() -> [Entry] {
        do{
            let data = try Data(contentsOf: fileURL())
            let decoder = JSONDecoder()
            let entries = try decoder.decode([Entry].self, from: data)
            return entries
        } catch {
            print("There was an error Loading from Persistent Store \(error) \(error.localizedDescription)")
        }
        return []
    }
    
    
}





