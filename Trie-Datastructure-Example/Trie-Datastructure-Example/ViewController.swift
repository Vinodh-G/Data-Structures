//
//  ViewController.swift
//  Trie-Datastructure-Example
//
//  Created by Vinodh Govind Swamy on 8/5/17.
//  Copyright © 2017 Vinodh Swamy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let trie = Trie()
        trie.insert(word: "Cat")
        trie.insert(word: "Car")
        trie.insert(word: "Cart")
        trie.insert(word: "Cars")
        trie.insert(word: "Cate")
        trie.insert(word: "Bat")
        trie.insert(word: "Bats")
        trie.insert(word: "Ball")
        
        print("Contains Bats \(trie.contains(word: "Bats"))")
        print("Contains Bars \(trie.contains(word: "Bars"))")
        print("Contains Cart \(trie.contains(word: "Cart"))")
        
        print("Suggestions for car : \(trie.getSuggestions(forString: "car"))")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

class Employee {
    var name    : String
    var title   : String
    var iCard   : ICard?
    init(inName:String, inTitle:String) {
        name = inName
        title = inTitle
    }
    deinit {
        print("Employee : \(name) removed");
    }
}

class ICard {
    var uniqueId : String
    weak var employee : Employee
    init(inUniqueId:String, inEmployee:Employee) {
        uniqueId = inUniqueId
        employee = inEmployee
    }
    
    deinit { print("ID \(uniqueId) removed") }
    
    func displayBadge() {
        print("Name : \(employee.name)")
        print("title : \(employee.title)")
    }
}

