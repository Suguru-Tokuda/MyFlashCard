//
//  SchoolClass+CoreDataProperties.swift
//  MyFlashCard
//
//  Created by Suguru on 12/2/17.
//  Copyright © 2017 Suguru. All rights reserved.
//
//

import Foundation
import CoreData


extension SchoolClass {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SchoolClass> {
        return NSFetchRequest<SchoolClass>(entityName: "SchoolClass")
    }

    @NSManaged public var classNum: String?
    @NSManaged public var classid: String?
    @NSManaged public var name: String?

}
