import UIKit
import CoreData

enum DecksResult {
    case success([Deck])
    case failure(Error)
}

public class DeckStore {
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MyFlashCard")
        container.loadPersistentStores(completionHandler: { (description, error) in
            if let error = error {
                    print("Error setting up Core Data (\(error)).")
            }
        })
        return container
    }()
    
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    private func processDeckRequest(data: Data?, error: Error?) -> DecksResult {
        guard let jsonData = data else {
            return .failure(error!)
        }
        return MyFlashCardAPI.decks(fromJSON: jsonData, into: persistentContainer.viewContext)
    }
    
    func fetchDeckForID(completion: @escaping (DecksResult) -> Void, deckid: String) {
        let url = MyFlashCardAPI.myFlashCardURL(method: .deckForID, parameter: deckid)
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        let task = session.dataTask(with: request) {
            (data, response, error) -> Void in
            let result = self.processDeckRequest(data: data, error: error)
            OperationQueue.main.addOperation {
                completion(result)
            }
        }
        task.resume()
    }
    
}
