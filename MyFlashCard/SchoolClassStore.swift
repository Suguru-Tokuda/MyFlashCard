import UIKit
import CoreData

enum SchoolClassesResult {
    case success([SchoolClass])
    case failure(Error)
}

public class SchoolClassStore {
    
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
    
    private func processSchoolClassRequest(data: Data?, error: Error?) -> SchoolClassesResult {
        guard let jsonData = data else {
            return .failure(error!)
        }
        return MyFlashCardAPI.classes(fromJSON: jsonData, into: self.persistentContainer.viewContext)
    }
    
    func fetchAllClasses(completion: @escaping (SchoolClassesResult) -> Void) {
        let url = MyFlashCardAPI.myFlashCardURL(method: .classes, parameter: "")
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        let task = session.dataTask(with: request) {
            (data, response, error) -> Void in
            let result = self.processSchoolClassRequest(data: data, error: error)
            OperationQueue.main.addOperation {
                completion(result)
            }
        }
        task.resume()
    }
    
    func fetchAllClassesOrderByClassnum(completion: @escaping (SchoolClassesResult) -> Void) {
        let url = MyFlashCardAPI.myFlashCardURL(method: .classesOrderByClassnum, parameter: "")
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        let task = session.dataTask(with: request) {
            (data, response, error) -> Void in
            let result = self.processSchoolClassRequest(data: data, error: error)
            OperationQueue.main.addOperation {
                completion(result)
            }
        }
        task.resume()
    }
    
    func fetchClassByDeckid(deckid: String, completion: @escaping (SchoolClassesResult) -> Void) {
        let url = MyFlashCardAPI.myFlashCardURL(method: .classByDeckid, parameter: deckid)
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        let task = session.dataTask(with: request) {
            (data, response, error) -> Void in
            let result = self.processSchoolClassRequest(data: data, error: error)
            OperationQueue.main.addOperation {
                completion(result)
            }
        }
        task.resume()
    }
    
    // MARK: - a method to get exisitng classes
    func fetchAllExistingClasses(completion: @escaping (SchoolClassesResult) -> Void) {
        let viewContext = self.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<SchoolClass> = SchoolClass.fetchRequest()
        
        viewContext.perform {
            do {
                let allClasses = try viewContext.fetch(fetchRequest)
                completion(.success(allClasses))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func fetchAllExistingClassesAsynchronously() -> [SchoolClass] {
        let viewContext = self.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<SchoolClass> = SchoolClass.fetchRequest()
        var retVal: [SchoolClass]!
        do {
            retVal = try viewContext.fetch(fetchRequest) as [SchoolClass]
        } catch let error as NSError {
            print("Error in fetching: \(error)")
        }
        return retVal
    }
    
    //MAKR: - Delete methods
    func deleteUnnecessarySchoolClasses(scoolClasses: [SchoolClass], targetid: String) {
        let viewContext = self.persistentContainer.viewContext
        for scoolClass in scoolClasses {
            if (scoolClass.id != targetid) {
                viewContext.delete(scoolClass)
            }
        }
        do {
            try viewContext.save()
        } catch let error as NSError {
            print(error)
        }
    }
    
    func deleteSchoolClassesFromArray(schoolClasses: [SchoolClass]) {
        let viewContext = self.persistentContainer.viewContext
        for schoolClass in schoolClasses {
            viewContext.delete(schoolClass)
        }
        do {
            try viewContext.save()
        } catch let error as NSError {
            print(error)
        }
    }
    
    func deleteAllTheClasses() {
        let viewContext = self.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<SchoolClass> = SchoolClass.fetchRequest()
        
        do {
            let schoolClasses = try viewContext.fetch(fetchRequest) as [SchoolClass]
            for schoolClass in schoolClasses {
                viewContext.delete(schoolClass)
            }
            try viewContext.save()
        } catch let error as NSError {
            print("Error in fetch : \(error)")
        }
        
    }
    
    
    
    
    
}
