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
                    self.appDelegate.decksToDownload = decks
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
        self.performSegue(withIdentifier: "searchByListSeg", sender: self)
        
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
