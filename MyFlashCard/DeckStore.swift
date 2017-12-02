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
    
    // MARK: - Core Data Saving support
    
    public func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
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
    
        // MARK: - Decks
    
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
    
    func fetchDeckForClassnumber(completion: @escaping (DecksResult) -> Void, classnumber: String) {
        let url = MyFlashCardAPI.myFlashCardURL(method: .decksForClassnumber, parameter: classnumber)
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
    

    func fetchDeckForDeckid(deckid: String, completion: @escaping (DecksResult) -> Void) {
        let url = MyFlashCardAPI.myFlashCardURL(method: .deckForID, parameter: deckid)
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        let task = session.dataTask(with: request) {
            (data, response, error) -> Void in
            let result = self.processDeckRequest(data: data, error: error)
            completion(result)
        }
        task.resume()
    }
    
    func fetchDecksForClassid(classid: String, completion: @escaping (DecksResult) -> Void) {
        let url = MyFlashCardAPI.myFlashCardURL(method: .dekcsForClassid, parameter: classid)
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        let task = session.dataTask(with: request) {
            (data, response, error) -> Void in
            let result = self.processDeckRequest(data: data, error: error)
            completion(result)
        }
        task.resume()
    }
    
    func fetchDecksForClassnumber(classnumber: String, completion: @escaping (DecksResult) -> Void) {
        let url = MyFlashCardAPI.myFlashCardURL(method: .decksForClassnumber, parameter: classnumber)
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        let task = session.dataTask(with: request) {
            (data, response, error) -> Void in
            let result = self.processDeckRequest(data: data, error: error)
            completion(result)
        }
        task.resume()
    }
    
    func fetchDecksForClassname(classname: String, completion: @escaping (DecksResult) -> Void) {
        let url = MyFlashCardAPI.myFlashCardURL(method: .decksForClassname, parameter: classname)
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        let task = session.dataTask(with: request) {
            (data, response, error) -> Void in
            let result = self.processDeckRequest(data: data, error: error)
            completion(result)
        }
        task.resume()
    }
    
    func fetchDecksForUsername(username: String, completion: @escaping (DecksResult) -> Void) {
        let url = MyFlashCardAPI.myFlashCardURL(method: .decksForUsername, parameter: username)
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        let task = session.dataTask(with: request) {
            (data, response, error) -> Void in
            let result = self.processDeckRequest(data: data, error: error)
            completion(result)
        }
        task.resume()
    }
    
    func fetchDecksForKeyword(keyword: String, completion: @escaping (DecksResult) -> Void) {
        let url = MyFlashCardAPI.myFlashCardURL(method: .decksForKeyword, parameter: keyword)
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        let task = session.dataTask(with: request) {
            (data, response, error) -> Void in
            let result = self.processDeckRequest(data: data, error: error)
            completion(result)
        }
        task.resume()
    }
    
    // MARK: - a method to get exisitng decks
    func fetchAllExistingDecks(completion: @escaping (DecksResult) -> Void) {
        let viewContext = self.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Deck> = Deck.fetchRequest()
        
        viewContext.perform {
            do {
                let allDecks = try viewContext.fetch(fetchRequest)
                completion(.success(allDecks))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    
    
}
