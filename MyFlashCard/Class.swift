import Foundation

public class Class {
    
    private var classNum: String;
    private var className: String;
    private var classID: String;
    private var decks = [Deck]();
    
    // initiallizers
    public init() {
        classNum = "";
        className = "";
        classID = "";
        decks = [Deck]();
    }
    
    public init(classNum: String, className: String, classID: String, decks: [Deck]) {
        self.classNum = classNum;
        self.className = className;
        self.classID = classID;
        self.decks = decks;
    }
    
    // getters & setters
    public func getClassNum() -> String {
        return classNum;
    }
    
    public func setClassNum(classNum: String) {
        self.classNum = classNum;
    }
    
    public func getClassName() -> String {
        return className;
    }
    
    public func setClassName(className: String) {
        self.className = className;
    }
    
    public func getClassID() -> String {
        return classID;
    }
    
    public func setClassID(classID: String) {
        self.classNum = classID;
    }
    
    public func getDecks() -> [Deck] {
        return decks;
    }
    public func setDekcs(decks: [Deck]) {
        self.decks = decks;
    }
    
}
