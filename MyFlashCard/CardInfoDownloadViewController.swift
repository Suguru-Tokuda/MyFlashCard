import Foundation
import UIKit
import CoreData

class CardInfoDownloadViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var cardTableView: UITableView!
    @IBOutlet weak var titleText: UINavigationItem!
    var cardsToDownload: [Card]!
    var decksToDownload: [Deck]!
    var schoolClassesToDownload: [SchoolClass]!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var deckName: String!
    var questionString: String!
    var answerString: String!
    var cardStore: CardStore!
    var deckStore: DeckStore!
    var schoolClassStore: SchoolClassStore!
    var persistentContainer: NSPersistentContainer!
    var downloadMessage: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleText.title = deckName
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "cardDetailsSeg" {
            let vc : CardDetailsViewController = segue.destination as! CardDetailsViewController
            vc.questionString = self.questionString
            vc.answerString = self.answerString
        }
        if segue.identifier == "downloadSegue" {
            let vc = segue.destination as! CardsDownloadCompleteViewController
            vc.downloadMessage = self.downloadMessage
        }
    }
    
    //MARK: - TableViewDataSource
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let card = cardsToDownload[indexPath.row]
        questionString = card.question
        answerString = card.answer
        self.performSegue(withIdentifier: "cardDetailsSeg", sender: self)
    }
    
    //MARK: - TableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cardsToDownload = appDelegate.cardsToDownload
        return cardsToDownload.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cardCell", for: indexPath)
        cardsToDownload = appDelegate.cardsToDownload
        let card = cardsToDownload[indexPath.row]
        cell.textLabel?.text = card.question
        return cell
    }
    
    
    //MARK: - Button
    @IBAction func downloadButton(_ sender: Any) {
        let targetDeckid = self.appDelegate.targetDeckid
        let targetClassid = self.appDelegate.targetClassid
        cardStore = self.appDelegate.cardStore
        deckStore = self.appDelegate.deckStore
        
        schoolClassStore = self.appDelegate.schoolClassStore
        decksToDownload = self.appDelegate.decksToDownload
        schoolClassesToDownload = self.appDelegate.schoolClassesToDownload
        
        // delete objects which don't have the target id
        cardStore.deleteUnnecessaryCards(cards: cardsToDownload, targetid: targetDeckid!)
        deckStore.deleteUnnecessaryDecks(decks: decksToDownload, targetid: targetDeckid!)
        schoolClassStore.deleteUnnecessarySchoolClasses(scoolClasses: schoolClassesToDownload, targetid: targetClassid!)
        self.downloadMessage = "Downloaded \(deckName!)"
        
        cardStore.saveContext()
        self.appDelegate.existingSchoolClasses = schoolClassStore.fetchAllExistingClassesAsynchronously()
        // reset target keys
        self.appDelegate.targetDeckid = nil
        self.appDelegate.targetClassid = nil
        // reset todownload arrays
        self.appDelegate.cardsToDownload.removeAll()
        self.appDelegate.decksToDownload.removeAll()
        self.appDelegate.schoolClassesToDownload.removeAll()
        performSegue(withIdentifier: "downloadSegue", sender: self)
    }
}
