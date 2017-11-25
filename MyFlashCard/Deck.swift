import Foundation

public class Deck {
    
    private var deckName: String
    private var id: String
    
    // MARK: - initializers
    public init() {
        deckName = ""
        id = ""
    }
    
    public init(id: String, deckName: String) {
        self.id = id
        self.deckName = deckName
    }
    
    // MARK: - getters & setters
    public func getID() -> String {
        return id
    }
    
    public func setID(id: String) {
        self.id = id
    }
    
    public func getDeckName() -> String {
        return deckName
    }
    
    public func setDeckName(deckName: String) {
        self.deckName = deckName
    }
}
