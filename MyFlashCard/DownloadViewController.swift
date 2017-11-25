import UIKit

class DownloadViewController: UIViewController {
    
    // "!" means I know this optional variable definitely has a value, so let me use it directly.
    var store: CardStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.store = appDelegate.store
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func downloadButton(_ sender: Any) {
        print("download button clicked")
        store.fetchCardsForDeckID(deckid: "3") { (cardsResult) in
            switch cardsResult {
            case let .success(cards):
                print("Successfully found \(cards.count) cards.")
            case let .failure(error):
                print("Error fetching cards: \(error)")
            }
        }
        
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
