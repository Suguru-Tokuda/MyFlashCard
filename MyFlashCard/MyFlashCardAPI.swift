import Foundation

enum Method: String {
    case cardsForDeckid = "cards/findByDeckid/"
    case cardsForDeckname = "cards/findByDeckname/"
    case classes = "classes"
    case deckForID = "decks/"
    case decksForDeckname = "decks/findByDeckname"
    case dekcsForClassid = "decks/findByClassid/"
    case decksForClassnumber = "decks/findByClassnumber/"
    case decksForClassname = "decks/findbyClassname/"
    case decksForUsername = "decks/findByUsername/"
    case decksForKeyword = "decks/findByKeyword/"
    case users = "users"
}

struct MyFlashCardAPI {
    
    private static let baseURLString = "http://gfish3.it.ilstu.edu:8080/stokuda_fall2017_MyFlashCardWS/webresources/entities"
    
    public static func myFlashCardURL(method: Method, paramter: String) -> URL {
        var url: URL = URL(fileURLWithPath: baseURLString + paramter)
        return url
    }
    
}
