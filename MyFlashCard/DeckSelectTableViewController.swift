import UIKit

class DeckSelectTableViewController: UITableViewController {
    
    var decks: [Deck]!
    var cardStore: CardStore!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // get the deck id and prepare for the study.
        self.cardStore = appDelegate.cardStore
        let deckid = decks[indexPath.row].id
        cardStore.fetchExistingCardsForDeckID(completion: { (cardsResult) in
            switch cardsResult {
                case let .success(cards):
                    print("Successfully fetched \(cards.count) cards.")
                self.appDelegate.cardsToStudy = cards
                self.performSegue(withIdentifier: "cardsConfSeg", sender: self)
            case let .failure(error):
                print("Error fetching classes: \(error)")
            }
        }, deckid: deckid!)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        decks = appDelegate.studyDecks
        return decks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myDeckCardCell")
        let deck = decks[indexPath.row]
        cell?.textLabel?.text = deck.deckName!
        return cell!
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
