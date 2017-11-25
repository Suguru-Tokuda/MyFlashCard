import Foundation

public class Card {
    
    private var question: String
    private var answer: String
    private var cardID: Int
    private var deckID: Int
    private var priority: Int
    private var marked: Bool
    
    // MARK: - default constructor
    public init() {
        question = ""
        answer = ""
        cardID = 0
        deckID = 0
        priority = 0
        marked = false
    }
    
    public init(question: String, answer: String, cardID: Int, deckID: Int, priority: Int, marked: Bool) {
        self.question = question
        self.answer = answer
        self.cardID = cardID
        self.deckID = deckID
        self.priority = priority
        self.marked = marked
    }
    
    public func check() {
        if (self.marked == false) {
            self.marked = true
        }
    }
    
    public func uncheck() {
        if (self.marked == true) {
            self.marked = false
        }
    }
    
    // MARK: - getters & setters
    public func getQuestion() -> String {
        return question
    }
    
    public func setQuestion(question: String) {
        self.question = question
    }
    
    public func getAnswer() -> String {
        return answer
    }
    
    public func setAnswer(answer: String) {
        self.answer = answer
    }
    
    public func getCardID() -> Int {
        return self.cardID
    }
    
    public func setCardID(cardID: Int) {
        self.cardID = cardID
    }
    
    public func getDeckID() -> Int {
        return self.deckID
    }
    
    public func setDeckID(deckID: Int) {
        self.deckID = deckID
    }
    
    public func getPriority() -> Int {
        return self.priority
    }
    
    public func setPriority(priority: Int) {
        self.priority = priority
    }
    
    
    
    
    
}
