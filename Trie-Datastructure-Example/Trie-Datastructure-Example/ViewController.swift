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
        
//        let trie = Trie()
//        trie.insert(word: "Cat")
//        trie.insert(word: "Car")
//        trie.insert(word: "Cart")
//        trie.insert(word: "Cars")
//        trie.insert(word: "Cate")
//        trie.insert(word: "Bat")
//        trie.insert(word: "Bats")
//        trie.insert(word: "Ball")
//
//        print("Contains Bats \(trie.contains(word: "Bats"))")
//        print("Contains Bars \(trie.contains(word: "Bars"))")
//        print("Contains Cart \(trie.contains(word: "Cart"))")
//
//        print("Suggestions for car : \(trie.getSuggestions(forString: "car"))")
        
        
        let peopleTrie = Trie<Person>()
        let john = Person(inFirstName: "John", inLastName: "Carter", inContact: "234234")
        let joe = Person(inFirstName: "Joe", inLastName: "Luke", inContact: "234244")
        let joes = Person(inFirstName: "Joes", inLastName: "Cashin", inContact: "234244")
        let jake = Person(inFirstName: "Jake", inLastName: "William", inContact: "234254")
        let julian = Person(inFirstName: "Jalian", inLastName: "Thomas", inContact: "32423")
        
        peopleTrie.insert(item: john)
        peopleTrie.insert(item: joe)
        peopleTrie.insert(item: joes)
        peopleTrie.insert(item: jake)
        
        print("Contains \(john.firstName): \(peopleTrie.contains(element: john))")
        print("Contains \(joe.firstName): \(peopleTrie.contains(element: joe))")
        print("Contains \(julian.firstName): \(peopleTrie.contains(element: julian))")
        print("Contains \(jake.firstName): \(peopleTrie.contains(element: jake))")
        
        print("Suggestions for Jos :");
        let suggestions = peopleTrie.getSuggestions(forString: "joe")
        for person : Person in suggestions {
            print("\(person.firstName) \(person.lastName)")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

