import UIKit

enum SchoolClassesResult {
    case success([SchoolClass])
    case failure(Error)
}

public class SchoolClassStore {
    
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    private func processSchoolClassRequest(data: Data?, error: Error?) -> SchoolClassesResult {
        guard let jsonData = data else {
            return .failure(error!)
        }
        return MyFlashCardAPI.classes(fromJSON: jsonData)
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
    
    
    
    
    
}
