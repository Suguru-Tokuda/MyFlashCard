//
//  Card+CoreDataProperties.swift
//  MyFlashCard
//
//  Created by Suguru on 11/25/17.
//  Copyright © 2017 Suguru. All rights reserved.
//
//

import Foundation
import CoreData


extension Card {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Card> {
        return NSFetchRequest<Card>(entityName: "Card")
    }

    @NSManaged public var id: String?
    @NSManaged public var question: String?
    @NSManaged public var answer: String?
    @NSManaged public var deckID: String?
    @NSManaged public var priority: Int32
    @NSManaged public var marked: Bool
    @NSManaged public var deck: Deck?

}
