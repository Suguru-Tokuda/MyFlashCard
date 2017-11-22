import Foundation

public class Deck {
    
    private var deckName: String;
    
    // initializers
    public init() {
        deckName = "";
    }
    
    public init(deckName: String) {
        self.deckName = deckName;
    }
    
    // getters & setters
    public func getDeckName() -> String {
        return deckName;
    }
    
    public func setDeckName(deckName: String) {
        self.deckName = deckName;
    }
}
