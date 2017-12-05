import UIKit

class MyDecksViewController: UIViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var cardStore : CardStore!
    var schoolClassStore : SchoolClassStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
     // MARK: - Navigation
     

     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
     }
    

    @IBAction func button(_ sender: Any) {
        cardStore = appDelegate.cardStore
        cardStore.fetchAllExistingCards { (cardsResult) in
            switch cardsResult {
                case let .success(cards):
                    print("Num of cards \(cards.count)")
                    self.appDelegate.cardsToDownload = cards
                    self.performSegue(withIdentifier: "showSavedCardsSeg", sender: self)
            case let .failure(error):
                print("Error fetching cards: \(error)")
            }
        }
    }
    
    @IBAction func classesBtn(_ sender: Any) {
        schoolClassStore = appDelegate.schoolClassStore
        schoolClassStore.fetchAllExistingClasses { (schoolClassesResult) in
            switch schoolClassesResult {
                case let .success(schoolClasses):
                print("Num of classes \(schoolClasses.count)")
                case let .failure(error):
                print("Error fetching cards: \(error)")
            }
        }
    }
    
    @IBAction func deckBtn(_ sender: Any) {
    }
    
    
    
    
    

}
