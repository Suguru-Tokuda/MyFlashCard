//
//  SchoolClassModel.swift
//  MyFlashCard
//
//  Created by Suguru on 12/2/17.
//  Copyright © 2017 Suguru. All rights reserved.
//

import Foundation

public class SchoolClassModel {
    
    private var id: String?
    private var classNum: String?
    private var name: String?
    
    public init() {
    }
    
    public init(id: String, classNum: String, name: String) {
        self.id = id
        self.classNum = classNum
        self.name = name
    }
    
    public func getId() -> String? {
        return self.id
    }
    
    public func setId(id: String) {
        self.id = id
    }
    
    public func getClassNum() -> String? {
        return self.classNum
    }
    
    public func setClassNum(classNum: String) {
        self.classNum = classNum
    }
    
    public func getName() -> String? {
        return self.name
    }
    
    public func setName(name: String) {
        self.name = name
    }

    
    
}
