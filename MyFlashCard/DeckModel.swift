//
//  DeckModel.swift
//  MyFlashCard
//
//  Created by Suguru on 12/2/17.
//  Copyright © 2017 Suguru. All rights reserved.
//

import Foundation

public class DeckModel {
    
    private var id: String?
    private var deckname: String?
    private var classid: String?
    
    public init() {
    }
    
    public init(id: String, deckname: String, classid: String) {
        self.id = id
        self.deckname = deckname
        self.classid = classid
    }
    
    public func getId() -> String? {
        return self.id
    }
    
    public func setId(id: String) {
        self.id = id
    }
    
    public func getDeckname() -> String? {
        return self.deckname
    }
    
    public func setDeckname(deckname: String) {
        self.deckname = deckname
    }

    public func getClassid() -> String? {
        return self.classid
    }
    
    public func setClassid(classid: String) {
        self.classid = classid
    }

    
}
