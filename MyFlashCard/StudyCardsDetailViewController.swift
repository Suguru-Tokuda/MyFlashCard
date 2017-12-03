import UIKit

class StudyCardsDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var cards: [Card]!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var answer: String!
    var question: String!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cards = self.appDelegate.cardsToStudy
        return cards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "studyCardCell")
        let card = cards[indexPath.row]
        cell?.textLabel?.text = card.question
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let card = cards[indexPath.row]
        self.appDelegate.studyCard = card
        self.answer = card.answer
        self.question = card.question
        self.performSegue(withIdentifier: "cardSummarySeg", sender: self)
    }
    
    @IBOutlet weak var studyButton: UIButton!
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "cardSummarySeg" {
//            let vc = segue.destination as! CardSummaryViewController
//        }
    }

}
