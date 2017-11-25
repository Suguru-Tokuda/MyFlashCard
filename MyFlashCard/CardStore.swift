import Foundation

enum CardsResult {
    case success([Card])
    case failure(Error)
}

public class CardStore {
    
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    private func processCardRequest(data: Data?, error: Error?) -> CardsResult {
        guard let jsonData = data else {
            return .failure(error!)
        }
        return MyFlashCardAPI.cards(fromJSON: jsonData)
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
            completion(result)
        }
        task.resume()
    }
    // MARK: - Cards
    func fetchCardsForDeckID(deckID: String) {
        let url = MyFlashCardAPI.myFlashCardURL(method: .cardsForDeckid, parameter: deckID)
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        let task = session.dataTask(with: request) {
            (data, response, error) -> Void in
            
            if let jsonData = data {
                if let jsonString = String(data: jsonData, encoding: .utf8) {
                    print(jsonString)
                }
            } else if let requestError = error {
                print("Error fetching cards: \(requestError)")
            } else {
                print("Unexpected error with the request")
            }
        }
        task.resume()
    }
    
    func fetchCardsForDeckname(deckName: String) {
        let url = MyFlashCardAPI.myFlashCardURL(method: .cardsForDeckname, parameter: deckName)
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        let task = session.dataTask(with: request) {
            (data, response, error) -> Void in
            
            if let jsonData = data {
                if let jsonString = String(data: jsonData, encoding: .utf8) {
                    print(jsonString)
                }
            } else if let requestError = error {
                print("Error fetching cards: \(requestError)")
            } else {
                print("Unexpected error with the request")
            }
        }
        task.resume()
    }
    
    // MARK: - Decks
    func fetchDeckForDeckid(deckID: String) {
        let url = MyFlashCardAPI.myFlashCardURL(method: .deckForID, parameter: deckID)
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        let task = session.dataTask(with: request) {
            (data, response, error) -> Void in
            
            if let jsonData = data {
                if let jsonString = String(data: jsonData, encoding: .utf8) {
                    print(jsonString)
                }
            } else if let requestError = error {
                print("Error fetching cards: \(requestError)")
            } else {
                print("Unexpected error with the request")
            }
        }
        task.resume()
    }
    
    func fetchDecksForClassid(classid: String) {
        let url = MyFlashCardAPI.myFlashCardURL(method: .dekcsForClassid, parameter: classid)
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        let task = session.dataTask(with: request) {
            (data, response, error) -> Void in
            
            if let jsonData = data {
                if let jsonString = String(data: jsonData, encoding: .utf8) {
                    print(jsonString)
                }
            } else if let requestError = error {
                print("Error fetching cards: \(requestError)")
            } else {
                print("Unexpected error with the request")
            }
        }
        task.resume()
    }
    
    func fetchDecksForClassnumber(classnumber: String) {
        let url = MyFlashCardAPI.myFlashCardURL(method: .decksForClassnumber, parameter: classnumber)
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        let task = session.dataTask(with: request) {
            (data, response, error) -> Void in
            
            if let jsonData = data {
                if let jsonString = String(data: jsonData, encoding: .utf8) {
                    print(jsonString)
                }
            } else if let requestError = error {
                print("Error fetching cards: \(requestError)")
            } else {
                print("Unexpected error with the request")
            }
        }
        task.resume()
    }
    
    func fetchDecksForClassname(classname: String) {
        let url = MyFlashCardAPI.myFlashCardURL(method: .decksForClassname, parameter: classname)
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        let task = session.dataTask(with: request) {
            (data, response, error) -> Void in
            
            if let jsonData = data {
                if let jsonString = String(data: jsonData, encoding: .utf8) {
                    print(jsonString)
                }
            } else if let requestError = error {
                print("Error fetching cards: \(requestError)")
            } else {
                print("Unexpected error with the request")
            }
        }
        task.resume()
    }
    
    func fetchDecksForUsername(userName: String) {
        let url = MyFlashCardAPI.myFlashCardURL(method: .decksForUsername, parameter: userName)
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        let task = session.dataTask(with: request) {
            (data, response, error) -> Void in
            
            if let jsonData = data {
                if let jsonString = String(data: jsonData, encoding: .utf8) {
                    print(jsonString)
                }
            } else if let requestError = error {
                print("Error fetching cards: \(requestError)")
            } else {
                print("Unexpected error with the request")
            }
        }
        task.resume()
    }
    
    func fetchDecksForKeyword(keyword: String) {
        let url = MyFlashCardAPI.myFlashCardURL(method: .decksForKeyword, parameter: keyword)
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        let task = session.dataTask(with: request) {
            (data, response, error) -> Void in
            
            if let jsonData = data {
                if let jsonString = String(data: jsonData, encoding: .utf8) {
                    print(jsonString)
                }
            } else if let requestError = error {
                print("Error fetching cards: \(requestError)")
            } else {
                print("Unexpected error with the request")
            }
        }
        task.resume()
    }
    
    
    
}
