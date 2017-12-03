//
//  CardModel.swift
//  MyFlashCard
//
//  Created by Suguru on 12/2/17.
//  Copyright © 2017 Suguru. All rights reserved.
//

import Foundation

public class CardModel {
    
    private var answer: String?
    private var question: String?
    private var deckid: String?
    private var id: String?
    private var priority: Int?

    
    public init() {
    }
    
    public init(answer: String, question: String, deckid: String, id: String, priority: Int) {
        self.answer = answer;
        self.question = question;
        self.deckid = deckid;
        self.id = id;
        self.priority = priority;
    }
    
    public func getAnswer() -> String? {
        return self.answer
    }
    
    public func setAnswer(answer: String) {
        self.answer = answer
    }
    
    public func getQuestion() -> String? {
        return self.question
    }
    
    public func setQuestion(question: String) {
    self.question = question
    }
    
    public func getDeckid() -> String? {
        return self.deckid
    }
    
    public func setDeckid(deckid: String) {
        self.deckid = deckid
    }
    
    public func getId() -> String? {
        return self.id
    }
    
    public func setId(id: String) {
        self.id = id
    }
    
    public func getPrioirty() -> Int? {
        return self.priority
    }
    
    public func setPriority(priority: Int) {
        self.priority = priority
    }
    
    
    
    
}
