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
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
            guard
                let jsonDictionary = jsonObject as? AnyObject
                else {
                    // The JSON strcuture doesn't match our expectaions
                    return .failure(MyFlashCardError.invalidJSONData)
            }
            let cardArray = jsonDictionary as! [AnyObject]

            var finalCards = [Card]()
            for cardJSON in jsonDictionary as! [AnyObject] {
                let cardJSONString = cardJSON as! [String:Any]
                if let card = card(fromJSON: cardJSONString) {
                    finalCards.append(card)
                }
            }
            
            if finalCards.isEmpty && !cardArray.isEmpty {
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
        guard
            let question = json["question"] as? String,
            let answer = json["answer"] as? String,
            let deckid = json["deckid"] as? Int,
            let id = json["id"] as? Int,
            let priority = json["priority"] as? Int else {
                return nil
        }
        
        let card = Card(question: question, answer: answer, cardID: String(id), deckID: String(deckid), priority: priority, marked: false)
        return card
    }
    
}
