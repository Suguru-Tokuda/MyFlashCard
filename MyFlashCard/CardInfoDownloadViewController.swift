import Foundation
import UIKit

class CardInfoDownloadViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    

    @IBOutlet weak var cardTableView: UITableView!
    var cards : [Card]!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
    
    //MARK: - TableViewDataSource
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
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
        
    }
}
