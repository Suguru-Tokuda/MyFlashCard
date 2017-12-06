import UIKit

class DecksInfoDownloadViewController: UITableViewController {
    
    var decksToDownload: [Deck]!
    var existingDecks: [Deck]!
    var backButtonString : String!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var cardStore : CardStore!
    var deckName : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // will send a deckID
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fromDecksToCards" {
            let vc = segue.destination as! CardInfoDownloadViewController
            vc.deckName = self.deckName
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        decksToDownload = appDelegate.decksToDownload
        existingDecks = appDelegate.existingDecks
        //        var index: Int!
        //        for deck in decksToDownload {
        //            if existingDecks.contains(deck) {
        //                index = decksToDownload.index(of: deck)
        //                self.decksToDownload.remove(at: index)
        //            }
        //        }
        self.appDelegate.decksToDownload = self.decksToDownload
        return decksToDownload.count;
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.cardStore = appDelegate.cardStore
        let deck = self.decksToDownload[indexPath.row]
        let deckid = deck.id!
        self.deckName = deck.deckName
        self.appDelegate.targetDeckid = deckid
        
        let targetClassid = self.appDelegate.targetClassid
        if targetClassid == nil {
            let schoolClassStore = self.appDelegate.schoolClassStore
            schoolClassStore?.fetchClassByDeckid(deckid: deckid, completion: { (schoolClassesResult) in
                switch schoolClassesResult {
                case let .success(schoolClasses):
                    var tempSchoolClassArray = self.appDelegate.schoolClassesToDownload
                    for schoolClass in schoolClasses {
                        if tempSchoolClassArray?.contains(schoolClass) == false {
                            tempSchoolClassArray?.append(schoolClass)
                            self.appDelegate.targetClassid = schoolClass.id
                        }
                    }
                    self.appDelegate.schoolClassesToDownload = tempSchoolClassArray
                case let .failure(error):
                    print("Error in fetching a class: \(error)")
                }
            })
        }
        
        cardStore.fetchCardsForDeckID(deckid: deckid) { (cardsResult) in
            switch cardsResult {
            case let .success(cards):
                var tempCardArray = self.appDelegate.cardsToDownload
                for card in cards {
                    if tempCardArray?.contains(card) == false {
                        tempCardArray?.append(card)
                    }
                }
                appDelegate.cardsToDownload = tempCardArray
                print("Successfully found \(cards.count) cards")
                self.performSegue(withIdentifier: "fromDecksToCards", sender: self)
            case let .failure(error):
                print("Error fetching cards: \(error)")
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create an instance of UITableViewCell, with default appearance
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "UITableViewCell")
        decksToDownload = appDelegate.decksToDownload
        
        // Set the text on the cell with the description of the item
        // that is at the nth index of items, where n = row this cell
        // will appear in on the tableview
        
        let deck = decksToDownload[indexPath.row]
        cell.textLabel?.text = deck.deckName
        return cell
    }
    
    
}
