import UIKit

class ClassInfoDownloadViewController: UITableViewController {
    
    // "!" means I know this optional variable definitely has a value, so let me use it directly.
    var cardStore: CardStore!
    var deckStore: DeckStore!
    var schoolClassStore: SchoolClassStore!
    var cards: [Card]!
    var schoolClasses: [SchoolClass]!
    var backButtonTitle : String!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cardStore = appDelegate.cardStore
        self.schoolClassStore = appDelegate.schoolClassStore
        
        // Get the height of the status bar
//        let statusBarHeight = UIApplication.shared.statusBarFrame.height
//        
//        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
//        tableView.contentInset = insets
//        tableView.scrollIndicatorInsets = insets
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        schoolClasses = appDelegate.schoolClassesToDownload
        return schoolClasses.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create an instance of UITableViewCell, with default appearance
        let cell = tableView.dequeueReusableCell(withIdentifier: "classDownloadCell")
        
        // Set the text on the cell with the description of the item
        // that is at the nth index of items, where n = row this cell
        // will appear in on the tableview
        let schoolClass = schoolClasses[indexPath.row]
        cell?.textLabel?.text = "\(schoolClass.classNum!) \(schoolClass.name!)"
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.deckStore = appDelegate.deckStore
        let schoolClass = self.schoolClasses[indexPath.row]
        let classnumber = schoolClass.classNum
        self.appDelegate.targetClassid = schoolClass.id
        
        deckStore.fetchDeckForClassnumber(completion: { (dekcsResult) in
            switch dekcsResult {
            case let .success(decks):
                // assign a response decks to a global variable in appDelegate
                self.appDelegate.decksToDownload = decks
                print("Successfully found \(decks.count) decks")
                self.performSegue(withIdentifier: "fromClassToDeck", sender: self)
            case let . failure(error):
                print("Error fetching decks: \(error)")
                
            }
        }, classnumber: classnumber!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // will send a classID or something equivalent
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "fromClassToDeck" {
            var vc : DecksInfoDownloadViewController = segue.destination as! DecksInfoDownloadViewController
            vc.backButtonString = backButtonTitle
        }
        
    }
    
}
