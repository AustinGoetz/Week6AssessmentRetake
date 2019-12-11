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
    var personPairs: [[Person]] = []
    
    // MARK: - CRUD
    // Create
    func addPerson(name: String) {
        let newPerson = Person(name: name)
        
        persons.append(newPerson)
        
        // Save
    }
    
    func removePerson(_ person: Person) {
        guard let indexOfPersonToBeRemoved = persons.firstIndex(of: person) else { return }
        
        persons.remove(at: indexOfPersonToBeRemoved)
        
        // Save
    }
    
    // MARK: - Create Pairs
    
    
    // MARK: - Persistence
    

}
