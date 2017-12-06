import Foundation
import CoreData

enum Method: String {
    case allCards = ".cards/"
    case cardsForDeckid = ".cards/findByDeckid/"
    case cardsForDeckname = ".cards/findByDeckname/"
    case classes = ".classes"
    case classesOrderByClassnum = ".classes/allClassesOrderByClassnum/"
    case classByDeckid = ".classes/"
    case deckForID = ".decks/"
    case decksForDeckname = ".decks/findByDeckname/"
    case dekcsForClassid = ".decks/findByClassid/"
    case decksForClassnumber = ".decks/findByClassnumber/"
    case decksForClassname = ".decks/findbyClassname/"
    case decksForUsername = ".decks/findByUsername/"
    case decksForKeyword = ".decks/findByKeyword/"
    case allDecksOrderByDeckname = ".deck/allDecksOrderByDeckname/"
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
    
//    static func cards(fromJSON data: Data, into context: NSManagedObjectContext) -> CardsResult {
//        do {
//            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
//            guard
//                let jsonDictionary = jsonObject as? AnyObject
//                else {
//                    // The JSON strcuture doesn't match our expectaions
//                    return .failure(MyFlashCardError.invalidJSONData)
//            }
//            let cardArray = jsonDictionary as! [AnyObject]
//
//            var finalCards = [Card]()
//            for cardJSON in jsonDictionary as! [AnyObject] {
//                let cardJSONString = cardJSON as! [String:Any]
//                if let card = card(fromJSON: cardJSONString, into: context) {
//                    finalCards.append(card)
//                }
//            }
//
//            if finalCards.isEmpty && !cardArray.isEmpty {
//                // We weren't able to parse any of the photos
//                // Maybe the JSON format for photos has changed
//                return .failure(MyFlashCardError.invalidJSONData)
//            }
//            return .success(finalCards)
//        } catch let error {
//            return .failure(error)
//        }
//    }
    
    static func cards(fromJSON data: Data, into context: NSManagedObjectContext) -> CardsResult {
        var finalCards = [Card]()
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
            guard
            let cardsArray = jsonObject as? [[String:Any]]
                else {
                    // The JSON strcuture doesn't match our expectaions
                    let json = jsonObject as? [String:Any]
                    if let card = card(fromJSON: json!, into: context) {
                        finalCards.append(card)
                    }
                    return .success(finalCards)
//                    return .failure(MyFlashCardError.invalidJSONData)
            }
            
            for cardJSON in cardsArray {
                let cardJSONString = cardJSON
                if let card = card(fromJSON: cardJSONString, into: context) {
                    finalCards.append(card)
                }
            }
            if finalCards.isEmpty && !cardsArray.isEmpty {
                // We weren't able to parse any of the cards
                // Maybe the JSON format for photos has changed
                return .failure(MyFlashCardError.invalidJSONData)
            }
            return .success(finalCards)
        } catch let error {
            return .failure(error)
        }
    }
    
    static func classes(fromJSON data: Data, into context: NSManagedObjectContext) -> SchoolClassesResult {
        var finalClasses = [SchoolClass]()
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
            guard
            let classesArray = jsonObject as? [[String:Any]]
                else {
                    // The JSON structure doesn't match our expectations
//                    return .failure(MyFlashCardError.invalidJSONData)
                    let json = jsonObject as? [String:Any]
                    if let schoolClass = schoolClass(fromJSON: json!, into: context) {
                        finalClasses.append(schoolClass)
                    }
                    return .success(finalClasses)
            }
            for classJSON in classesArray {
                let classJSONString = classJSON
                if let schoolClass = schoolClass(fromJSON: classJSONString, into: context) {
                    finalClasses.append(schoolClass)
                }
            }
            return .success(finalClasses)
        } catch let error {
            return .failure(error)
        }
    }
    
    static func decks(fromJSON data: Data, into context: NSManagedObjectContext) -> DecksResult {
        var finalDecks = [Deck]()
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
            guard
            let decksArray = jsonObject as? [[String:Any]]
                else {
                    let json = jsonObject as? [String:Any]
                    if let deck = deck(fromJSON: json!, into: context) {
                        finalDecks.append(deck)
                    }
                    return .success(finalDecks)
                    // The JSON structure doesn't match our expectations
                    return .failure(MyFlashCardError.invalidJSONData)
            }
            for deckJSON in decksArray {
                let deckJSONString = deckJSON
                if let deck = deck(fromJSON: deckJSONString, into: context) {
                    finalDecks.append(deck)
                }
            }
            return .success(finalDecks)
        } catch let error {
            return .failure(error)
        }
    }
    
//    static func decks(fromJSON data: Data, into context: NSManagedObjectContext) -> DecksResult {
//        do {
//            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
//            guard
//                let jsonDictionary = jsonObject as? AnyObject
//                else {
//                    // The JSON structure doesn't match our expectations
//                    return .failure(MyFlashCardError.invalidJSONData)
//            }
//            let decksArray = jsonDictionary as! [AnyObject]
//            var finalDecks = [Deck]()
//            for deckJSON in decksArray {
//                let deckJSONString = deckJSON as! [String : Any]
//                if let deck = deck(fromJSON: deckJSONString, into: context) {
//                    finalDecks.append(deck)
//                }
//            }
//            return .success(finalDecks)
//        } catch let error {
//            return .failure(error)
//        }
//    }
    
    private static func card(fromJSON json: [String : Any], into context: NSManagedObjectContext) -> Card? {
        guard
            let question = json["question"] as? String,
            let answer = json["answer"] as? String,
            let deckid = json["deckid"] as? Int,
            let id = json["id"] as? Int,
            let priority = json["priority"] as? Int else {
                return nil
        }
        
        let fetchRequest: NSFetchRequest<Card> = Card.fetchRequest()
        let predicate = NSPredicate(format: "\(#keyPath(Card.id)) == \(id)")
        fetchRequest.predicate = predicate
        
        var fetchedCard: [Card]?
        context.performAndWait {
            fetchedCard = try? fetchRequest.execute()
        }
        if let existingCard = fetchedCard?.first {
            return existingCard
        }
        
        var card: Card!
        context.performAndWait {
            card = Card(context: context)
            card.answer = answer
            card.question = question
            card.deckid = String(deckid)
            card.id = String(id)
            card.priority = Int16(priority)
        }
        return card
    }
    
    private static func schoolClass(fromJSON json: [String : Any], into context: NSManagedObjectContext) -> SchoolClass? {
        guard
            let classname = json["classname"] as? String,
            let classnumber = json["classnumber"] as? String,
            let id = json["id"] as? Int else {
                return nil
        }
        
        let fetcRequest: NSFetchRequest<SchoolClass> = SchoolClass.fetchRequest()
        let predicate = NSPredicate(format: "\(#keyPath(SchoolClass.id)) == \(id)")
        fetcRequest.predicate = predicate
        
        var fetchedClasses: [SchoolClass]?
        context.performAndWait {
            fetchedClasses = try? fetcRequest.execute()
        }
        if let existingClass = fetchedClasses?.first {
            return existingClass
        }
        
        var schoolClass: SchoolClass!
        context.performAndWait {
            schoolClass = SchoolClass(context: context)
            schoolClass.name = classname
            schoolClass.id = String(id)
            schoolClass.classNum = classnumber
        }
        
        return schoolClass
    }
    
    private static func deck(fromJSON json: [String : Any], into context: NSManagedObjectContext) -> Deck? {
        guard
            let deckname = json["deckname"] as? String,
            let id = json["id"] as? Int,
            let classid = json["classid"] as? Int else {
                return nil
        }
        
        let fetchRequest: NSFetchRequest<Deck> = Deck.fetchRequest()
        let predicate = NSPredicate(format: "\(#keyPath(Deck.id)) == \(id)")
        fetchRequest.predicate = predicate
        
        var fetchedDecks: [Deck]?
        context.performAndWait {
            fetchedDecks = try? fetchRequest.execute()
        }
        if let existingDeck = fetchedDecks?.first {
            return existingDeck
        }
        
        var deck: Deck!
        context.performAndWait {
            deck = Deck(context: context)
            deck.id = String(id)
            deck.deckName = deckname
            deck.classid = String(classid)
        }
        return deck
    }
    
}
