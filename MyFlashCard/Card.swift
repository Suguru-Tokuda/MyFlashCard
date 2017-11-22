import Foundation

public class Card {
    
    private var question: String;
    private var answer: String;
    private var cardID: String;
    private var deckID: String;
    private var marked: Bool;
    
    // MARK: - default constructor
    public init() {
        question = "";
        answer = "";
        cardID = "";
        deckID = "";
        marked = false;
    }
    
    public init(question: String, answer: String, cardID: String, deckID: String, marked: Bool) {
        self.question = question;
        self.answer = answer;
        self.cardID = cardID;
        self.deckID = deckID;
        self.marked = marked;
    }
    
    public func check() {
        if (self.marked == false) {
            self.marked = true;
        }
    }
    
    public func uncheck() {
        if (self.marked == true) {
            self.marked = false;
        }
    }
    
    // MARK: - getters & setters
    public func getQuestion() -> String {
        return question;
    }
    
    public func setQuestion(question: String) {
        self.question = question;
    }
    
    public func getAnswer() -> String {
        return answer;
    }
    
    public func setAnswer(answer: String) {
        self.answer = answer;
    }
    
    public func getCardID() -> String {
        return self.cardID;
    }
    
    public func setCardID(cardID: String) {
        self.cardID = cardID;
    }
    
    public func getDeckID() -> String {
        return self.deckID;
    }
    
    public func setDeckID(deckID: String) {
        self.deckID = deckID;
    }
    
    
    
    
    
}
