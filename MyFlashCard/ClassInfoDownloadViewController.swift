import UIKit

class ClassInfoDownloadViewController: UIViewController {
    
    // "!" means I know this optional variable definitely has a value, so let me use it directly.
    var cardStore: CardStore!
    var schoolClassStore: SchoolClassStore!
    var cards: [Card]!
    var schoolClasses: [SchoolClass]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.cardStore = appDelegate.cardStore
        self.schoolClassStore = appDelegate.schoolClassStore
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func downloadButton(_ sender: Any) {
        print("download button clicked")
        schoolClassStore.fetchAllClasses { (schoolClassesResult) in
            switch schoolClassesResult {
                case let .success(schoolClasses):
                self.schoolClasses = schoolClasses
                print("Successfully found \(schoolClasses.count) classes.")
            case let .failure(error):
                print("Error fetching classes: \(error)")
            }
        }
    }
    
    // will send a classID or something equivalent
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
}
