//
//  Deck+CoreDataProperties.swift
//  MyFlashCard
//
//  Created by Suguru on 11/25/17.
//  Copyright © 2017 Suguru. All rights reserved.
//
//

import Foundation
import CoreData


extension Deck {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Deck> {
        return NSFetchRequest<Deck>(entityName: "Deck")
    }

    @NSManaged public var deckName: String?
    @NSManaged public var id: String?
    @NSManaged public var cards: Card?

}
