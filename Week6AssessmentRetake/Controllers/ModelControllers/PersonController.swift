//
//  PersonController.swift
//  Week6AssessmentRetake
//
//  Created by Austin Goetz on 12/11/19.
//  Copyright © 2019 Austin Goetz. All rights reserved.
//

import Foundation

class PersonController {
    
    // MARK: - Singleton
    static let shared = PersonController()
    
    // MARK: - SoT's
    var persons: [Person] = []
    var pairs: [[Person]] = []
    
    // MARK: - CRUD
    // Create
    func addPerson(name: String) {
        let newPerson = Person(name: name)
        
        persons.append(newPerson)
        
        saveToPersistentStore()
    }
    
    func removePerson(_ person: Person) {
        guard let indexOfPersonToBeRemoved = persons.firstIndex(of: person) else { return }
        
        persons.remove(at: indexOfPersonToBeRemoved)
        
        saveToPersistentStore()
    }
    
    // MARK: - Create Pairs
    
    func createRandomPairs() {
        let shuffledPersons = persons.shuffled()
        var onePairArray: [Person] = []
        var arrayOfPairs: [[Person]] = []
        
        for person in shuffledPersons {
            if onePairArray.count < 2 {
                onePairArray.append(person)
            } else {
                arrayOfPairs.append(onePairArray)
                onePairArray = []
                onePairArray.append(person)
            }
        }
        
        arrayOfPairs.append(onePairArray)
        pairs = arrayOfPairs
    }
    
    // MARK: - Persistence
    
    // Create JSON file
    func createFileURLForPersistence() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = urls[0].appendingPathComponent("Week6AssessmentRetake.json")
        
        return fileURL
    }
    
    // Save
    func saveToPersistentStore() {
        let jsonEncoder = JSONEncoder()
        
        do {
            let personJSON = try jsonEncoder.encode(persons)
            try personJSON.write(to: createFileURLForPersistence())
        } catch {
            print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
        }
    }
    
    // Load
    func loadFromPersistentStore() {
        let jsonDecoder = JSONDecoder()
        
        do {
            let jsonData = try Data(contentsOf: createFileURLForPersistence())
            let decodedPerson = try jsonDecoder.decode([Person].self, from: jsonData)
            persons = decodedPerson
        } catch {
            print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
        }
    }
}
