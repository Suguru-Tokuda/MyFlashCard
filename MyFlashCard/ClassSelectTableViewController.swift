//
//  ClassSelectViewController.swift
//  MyFlashCard
//
//  Created by Suguru on 12/2/17.
//  Copyright © 2017 Suguru. All rights reserved.
//

import UIKit

class ClassSelectTableViewController: UITableViewController {
    
    var existingSchoolClasses : [SchoolClass]!
    var deckStore : DeckStore!
    var schoolClassStore: SchoolClassStore!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        schoolClassStore = appDelegate.schoolClassStore
        existingSchoolClasses = schoolClassStore.fetchAllExistingClassesAsynchronously()
        self.appDelegate.existingSchoolClasses = existingSchoolClasses
    }
    
    override func viewWillAppear(_ animated: Bool) {
        existingSchoolClasses = self.appDelegate.existingSchoolClasses
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedClassid = self.existingSchoolClasses[indexPath.row].id
        self.deckStore = self.appDelegate.deckStore
        deckStore.fetchExistingDecksForClassid(completion: { (decksResult) in
            switch decksResult {
            case let .success(decks):
                print("Successfully found \(decks.count) decks.")
                self.appDelegate.existingDecks = decks
                self.performSegue(withIdentifier: "toExistingDecksSeg", sender: self)
            case let .failure(error):
                print("Error fetching classes: \(error)")
            }
        }, classid: selectedClassid!)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appDelegate.existingSchoolClasses.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "selectClassCell", for: indexPath)
        self.existingSchoolClasses = self.appDelegate.existingSchoolClasses
        let schoolClass = existingSchoolClasses[indexPath.row]
        cell.textLabel?.text = "\(schoolClass.classNum!) \(schoolClass.name!)"
        return cell
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
