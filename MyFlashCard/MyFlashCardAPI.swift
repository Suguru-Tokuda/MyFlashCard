import Foundation

enum Method: String {
    case allCards = ".cards/"
    case cardsForDeckid = ".cards/findByDeckid/"
    case cardsForDeckname = ".cards/findByDeckname/"
    case classes = ".classes"
    case deckForID = ".decks/"
    case decksForDeckname = ".decks/findByDeckname"
    case dekcsForClassid = ".decks/findByClassid/"
    case decksForClassnumber = ".decks/findByClassnumber/"
    case decksForClassname = ".decks/findbyClassname/"
    case decksForUsername = ".decks/findByUsername/"
    case decksForKeyword = ".decks/findByKeyword/"
    case users = ".users"
}

enum MyFlashCardError: Error {
    case invalidJSONData
}

struct MyFlashCardAPI {
    
    private static let baseURLString = "http://gfish3.it.ilstu.edu:8080/stokuda_fall2017_MyFlashCardWS/webresources/entities"
    
    public static func myFlashCardURL(method: Method, parameter: String) -> URL {
        let urlString = baseURLString + method.rawValue + parameter
        let url = URL(string: urlString)
        return url!
    }
    
    static func cards(fromJSON data: Data) -> CardsResult {
        do {
//            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as AnyObject
            print(jsonObject)
            guard
            let jsonDictionary = jsonObject as? [AnyHashable:Any],
            let cards = jsonDictionary["cards"] as? [String:Any],
            let cardsArray = cards["card"] as? [[String:Any]] else {
                    // The JSON strcuture doesn't match our expectaions
                    return .failure(MyFlashCardError.invalidJSONData)
            }
            var finalCards = [Card]()
            
            for cardJSON in cardsArray {
                if let card = card(fromJSON: cardJSON) {
                    finalCards.append(card)
                }
            }
            
            if finalCards.isEmpty && !cardsArray.isEmpty {
                // We weren't able to parse any of the photos
                // Maybe the JSON format for photos has changed
                return .failure(MyFlashCardError.invalidJSONData)
            }
            
            return .success(finalCards)
        } catch let error {
            return .failure(error)
        }
    }
    
    private static func card(fromJSON json: [String : Any]) -> Card? {
        print("func card func card func card func card")
        print("func card func card func card func card")
        print("func card func card func card func card")
        print("func card func card func card func card")
        guard
            let question = json["quesiton"] as? String,
            let answer = json["answer"] as? String,
            let deckid = json["deckid"] as? Int,
            let id = json["id"] as? Int,
            let priority = json["priority"] as? Int else {
                // Don't have enough information to construct a Card
                return nil
        }
        return Card(question: question, answer: answer, cardID: id, deckID: deckid, priority: priority, marked: false)
    }
    
}
