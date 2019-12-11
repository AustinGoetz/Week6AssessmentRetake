//
//  RandomPairsTableViewController.swift
//  Week6AssessmentRetake
//
//  Created by Austin Goetz on 12/11/19.
//  Copyright © 2019 Austin Goetz. All rights reserved.
//

import UIKit

class RandomPairsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        PersonController.shared.loadFromPersistentStore()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Actions
    
    @IBAction func addButtonTapped(_ sender: Any) {
        presentAddPersonViewController()
    }
    
    @IBAction func randomizeButtonTapped(_ sender: Any) {
        PersonController.shared.createRandomPairs()
        self.tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return PersonController.shared.pairs.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionTitle = "Pair \(section + 1)"
        
        return sectionTitle
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return PersonController.shared.pairs[section].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath)

        let pair = PersonController.shared.pairs[indexPath.section]
        let personToDisplay = pair[indexPath.row]
        
        cell.textLabel?.text = personToDisplay.name

        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // MARK: - Helpers
    
    func presentAddPersonViewController() {
        let alertController = UIAlertController(title: "Add Person", message: "Add someone new to the list", preferredStyle: .alert)
        let addButton = UIAlertAction(title: "Add", style: .default) { (action) in
            guard let newPerson = alertController.textFields?[0].text else { return }
            
            PersonController.shared.addPerson(name: newPerson)
            PersonController.shared.createRandomPairs()
            self.tableView.reloadData()
        }
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Name"
            textField.autocapitalizationType = .words
        }
        
        alertController.addAction(addButton)
        alertController.addAction(cancelButton)
        present(alertController, animated: true)
    }
}
