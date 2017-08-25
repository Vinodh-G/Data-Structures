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
        trie.insert(word: "Balls")
        
        print("Contains Bats \(trie.contains(word: "Bats"))")
        print("Contains Bars \(trie.contains(word: "Bars"))")
        print("Contains Cart \(trie.contains(word: "Cart"))")
        
        print("Suggestions for car : \(trie.getSuggestions(forString: "car"))")
        trie.delete(word: "ball")
        print("-> Suggestions for ba : \(trie.getSuggestions(forString: "ba"))")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

