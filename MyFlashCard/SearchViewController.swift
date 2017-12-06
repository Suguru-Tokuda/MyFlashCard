//
//  SearchViewController.swift
//  MyFlashCard
//
//  Created by Suguru on 12/3/17.
//  Copyright © 2017 Suguru. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    var deckStore: DeckStore!
    var schoolClassSotre: SchoolClassStore!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    @IBOutlet weak var keywordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func searchByKeywordBtn(_ sender: Any) {
        errorLabel.text = ""
        deckStore = self.appDelegate.deckStore
        if let text = keywordTextField.text, !text.isEmpty {
            let keyword = keywordTextField.text
            deckStore.fetchDecksForKeyword(keyword: keyword!, completion: { (decksResult) in
                switch decksResult {
                case let .success(decks):
                    var tempDeckArray = self.appDelegate.decksToDownload
                    for deck in decks {
                        if tempDeckArray?.contains(deck) == false {
                            tempDeckArray?.append(deck)
                        }
                    }
                    self.appDelegate.decksToDownload = tempDeckArray
                    print("Successfully fetched \(decks.count) decks")
                    self.performSegue(withIdentifier: "searchByKeywordSeg", sender: self)
                case let . failure(error):
                    print("Fetching error: \(error)")
                }
            })
        } else {
            errorLabel.text = "Fill the box to search"
        }
    }
    
    @IBAction func searchByListBtn(_ sender: Any) {
        schoolClassSotre = appDelegate.schoolClassStore
        schoolClassSotre.fetchAllClassesOrderByClassnum { (schoolClassesResult) in
            switch schoolClassesResult {
            case let .success(schoolClasses):
                var tempSchoolClassArray = self.appDelegate.schoolClassesToDownload
                for schoolClass in schoolClasses {
                    if tempSchoolClassArray?.contains(schoolClass) == false {
                        tempSchoolClassArray?.append(schoolClass)
                    }
                }
                self.appDelegate.schoolClassesToDownload = tempSchoolClassArray
                self.performSegue(withIdentifier: "searchByListSeg", sender: self)
            case let .failure(error):
                print("Erorr in fetching classes: \(error)")
            }
        }
    }
}
