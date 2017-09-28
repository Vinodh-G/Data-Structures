//
//  Person.swift
//  Trie-Datastructure-Example
//
//  Created by Vinodh Govind Swamy on 8/29/17.
//  Copyright © 2017 Vinodh Swamy. All rights reserved.
//

import Foundation

class Person: TrieValue {
    
    let firstName: String
    let lastName : String
    let uniqueId : String
    let contact : String
    
    var trieKey: String {
        return firstName
    }
    
    init(inFirstName:String, inLastName:String, inContact:String) {
        firstName = inFirstName
        lastName = inLastName
        contact = inContact
        uniqueId = ProcessInfo.processInfo.globallyUniqueString
    }
    
    var hashValue: Int = 0
    
    static func ==(lhs: Person, rhs: Person) -> Bool {
        return lhs.uniqueId == rhs.uniqueId
    }
    
    
}
