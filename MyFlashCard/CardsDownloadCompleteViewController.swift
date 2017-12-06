import UIKit

class CardsDownloadCompleteViewController: UIViewController {
    
    var downloadMessage: String!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var cardStore: CardStore!
    var deckStore: DeckStore!
    var schoolClassStore: SchoolClassStore!
    
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = downloadMessage
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func backBtnPushed(_ sender: Any) {
        schoolClassStore = self.appDelegate.schoolClassStore
        appDelegate.existingSchoolClasses = schoolClassStore.fetchAllExistingClassesAsynchronously()
        performSegue(withIdentifier: "backToTopSeg", sender: self)
    }
    
}
