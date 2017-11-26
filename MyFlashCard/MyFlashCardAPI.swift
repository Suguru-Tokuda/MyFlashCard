import Foundation
import CoreData

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
    
    static func cards(fromJSON data: Data, into context: NSManagedObjectContext) -> CardsResult {
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
                if let card = card(fromJSON: cardJSONString, into: context) {
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
    
    static func classes(fromJSON data: Data) -> SchoolClassesResult {
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
            guard
                let jsonDictionary = jsonObject as? AnyObject
                else {
                    // The JSON structure doesn't match our expectations
                    return .failure(MyFlashCardError.invalidJSONData)
            }
            let classesArray = jsonDictionary as! [AnyObject]
            
            var finalClasses = [SchoolClass]()
            for classJSON in classesArray {
                let classJSONString = classJSON as! [String:Any]
                if let schoolClass = schoolClass(fromJSON: classJSONString) {
                    finalClasses.append(schoolClass)
                }
            }
            return .success(finalClasses)
        } catch let error {
            return .failure(error)
        }
    }
    
    private static func card(fromJSON json: [String : Any], into context: NSManagedObjectContext) -> Card? {
        guard
            let question = json["question"] as? String,
            let answer = json["answer"] as? String,
            let deckid = json["deckid"] as? Int,
            let id = json["id"] as? Int,
            let priority = json["priority"] as? Int else {
                return nil
        }
        
        var card: Card!
        context.performAndWait {
            card = Card(context: context)
            card.answer = answer
            card.question = question
            card.deckID = String(deckid)
            card.id = String(id)
            card.priority = Int16(priority)
        }
        
        
//        let card = Card(question: question, answer: answer, cardID: String(id), deckID: String(deckid), priority: priority, marked: false)
        return card
    }
    
    private static func schoolClass(fromJSON json: [String : Any]) -> SchoolClass? {
        guard
            let classname = json["classname"] as? String,
            let classnumber = json["classnumber"] as? String,
            let classid = json["id"] as? Int else {
                return nil
            }
        let schoolClass = SchoolClass(classNum: classnumber, className: classname, classID: String(classid))
        return schoolClass
        }
    
}
