import Foundation
import UIKit
import CoreData

class CardInfoDownloadViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    

    @IBOutlet weak var cardTableView: UITableView!
    @IBOutlet weak var titleText: UINavigationItem!
    var cards : [Card]!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var deckName : String!
    var questionString : String!
    var answerString : String!
    var cardStore : CardStore!
    var persistentContainer : NSPersistentContainer!
    
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
//            let vc = segue.destination as! CardsDownloadCompleteViewController
        }
    }
    
    //MARK: - TableViewDataSource
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let card = cards[indexPath.row]
        questionString = card.question
        answerString = card.answer
        self.performSegue(withIdentifier: "cardDetailsSeg", sender: self)
    }
    
    //MARK: - TableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cards = appDelegate.cards
        return cards.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cardCell", for: indexPath)
        cards = appDelegate.cards
        let card = cards[indexPath.row]
        cell.textLabel?.text = card.question
        return cell
    }


    //MARK: - Button
    @IBAction func downloadButton(_ sender: Any) {
        cardStore = self.appDelegate.cardStore
        cardStore.saveContext()
        performSegue(withIdentifier: "downloadSegue", sender: self)
    }
}
