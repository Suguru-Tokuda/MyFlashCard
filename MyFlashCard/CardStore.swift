import UIKit
import CoreData

enum CardsResult {
    case success([Card])
    case failure(Error)
}

public class CardStore {
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MyFlashCard")
        container.loadPersistentStores(completionHandler: { (description, error) in
            if let error = error {
                print("Error setting up Core Data (\(error)).")
            }
        })
        return container
    }()
    
    public func resetContainer() {
        
    }
    
    // MARK: - Core Data Saving support
    public func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    private func processCardRequest(data: Data?, error: Error?) -> CardsResult {
        guard let jsonData = data else {
            return .failure(error!)
        }
        return MyFlashCardAPI.cards(fromJSON: jsonData, into: persistentContainer.viewContext)
    }
    
    private func processCardRequestWithoutContext(data: Data?, error: Error?) -> CardsResult {
        guard let jsonData = data else {
            return .failure(error!)
        }
        return MyFlashCardAPI.cards(fromJSON: jsonData, into: persistentContainer.viewContext)
    }
    
    // MARK: - REST calls
    // MARK: - Practice get all cards
    func fetchAllCards(completion: @escaping (CardsResult) -> Void) {
        let url = MyFlashCardAPI.myFlashCardURL(method: .allCards, parameter: "")
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        let task = session.dataTask(with: request) {
            (data, response, error) -> Void in
            let result = self.processCardRequest(data: data, error: error)
            OperationQueue.main.addOperation {
                completion(result)
            }
        }
        task.resume()
    }

    // MARK: - Cards
    func fetchCardsForDeckID(deckid: String, completion: @escaping (CardsResult) -> Void) {
        let url = MyFlashCardAPI.myFlashCardURL(method: .cardsForDeckid, parameter: deckid)
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        let task = session.dataTask(with: request) {
            (data, response, error) -> Void in
            let result = self.processCardRequest(data: data, error: error)
            OperationQueue.main.addOperation {
                completion(result)
            }
        }
        task.resume()
    }
    
    func fetchCardsForDeckname(deckname: String, completion: @escaping (CardsResult) -> Void) {
        let url = MyFlashCardAPI.myFlashCardURL(method: .cardsForDeckname, parameter: deckname)
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        let task = session.dataTask(with: request) {
            (data, response, error) -> Void in
            let result = self.processCardRequest(data: data, error: error)
            OperationQueue.main.addOperation {
                completion(result)
            }
        }
        task.resume()
    }
    
    // MARK: - a method to get exisitng cards
    func fetchAllExistingCards(completion: @escaping (CardsResult) -> Void) {
        let viewContext = self.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Card> = Card.fetchRequest()
        
        viewContext.perform {
            do {
                let allCards = try viewContext.fetch(fetchRequest)
                completion(.success(allCards))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func fetchExistingCardsForDeckID(completion: @escaping (CardsResult) -> Void, deckid: String) {
        let viewContext = self.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Card> = Card.fetchRequest()
        let predicate = NSPredicate(format: "deckid == %@", deckid)
        fetchRequest.predicate = predicate
        
        viewContext.perform {
            do {
                let allCards = try viewContext.fetch(fetchRequest)
                completion(.success(allCards))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    //MAKR: - Delete methods
    func deleteUnnecessaryCards(cards: [Card], targetid: String) {
        let viewContext = self.persistentContainer.viewContext
        for card in cards {
            if (card.deckid != targetid) {
                viewContext.delete(card)
            }
        }
        do {
            try viewContext.save()
        } catch let error as NSError {
            print(error)
        }
    }
    
    func deleteAllTheCards() {
        let viewContext = self.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Card> = Card.fetchRequest()
        
        do {
            let cards = try viewContext.fetch(fetchRequest) as [Card]
            for card in cards {
                viewContext.delete(card)
            }
            try viewContext.save()
        } catch let error as NSError {
            print("Error in fetch : \(error)")
        }
    }
    
}
