//
//  Trie.swift
//  Trie-Datastructure-Example
//
//  Created by Vinodh Govind Swamy on 8/5/17.
//  Copyright © 2017 Vinodh Swamy. All rights reserved.
//

import Foundation


class TrieNode < T:Hashable> {
    var value : T?
    weak var parent : TrieNode?
    var children : [T:TrieNode] = [:]
    var isCompleteWord : Bool = false
    init(inValue:T? = nil, inParent:TrieNode? = nil) {
        value = inValue
        parent = inParent
    }
    
    func add(newChild : T) {
        guard children[newChild] == nil else { return }
        children[newChild] = TrieNode(inValue: newChild, inParent: self)
    }
}

class Trie {
    typealias Node = TrieNode<Character>
    fileprivate let root : Node
    init() {
        root = Node()
    }
}

extension Trie {
    
    
    func insert(word : String) {
        guard !word.isEmpty else { return }
        
        var currentNode = root
        var currentIndex = 0;
        let characters = Array(word.lowercased().characters)
        
        while currentIndex < characters.count {
            let character = characters[currentIndex]
            
            if let child = currentNode.children[character] {
                currentNode = child
            } else {
                currentNode.add(newChild: character)
                currentNode = currentNode.children[character]!
            }
            currentIndex += 1
        }
        
        if currentIndex == characters.count {
            currentNode.isCompleteWord = true
        }
    }
    
    func contains(word : String) -> Bool {
        var containsWord = false
        guard !word.isEmpty else { return  containsWord }
        
        var currentIndex = 0
        var currentNode = root
        let characters = Array(word.lowercased().characters)
        
        while currentIndex < characters.count, let child = currentNode.children[characters[currentIndex]] {
            currentNode = child
            currentIndex += 1
        }
        
        if currentIndex == characters.count && currentNode.isCompleteWord {
            containsWord = true
        }
        
        return containsWord
    }
    
    func getSuggestions(forString:String) -> [String] {
        var suggestions : [String] = []
        
        guard !forString.isEmpty else { return  suggestions }
        
        let currentNode = getCurrentNode(forString:forString)
        
        suggestions += getStringSuggestions(fromNode: currentNode, withPrefix: forString)

        return suggestions
    }
    
    func getCurrentNode(forString:String) -> TrieNode<Character> {
        
        var currentIndex = 0
        var currentNode = root
        let characters = Array(forString.lowercased().characters)
        
        while currentIndex < characters.count, let child = currentNode.children[characters[currentIndex]] {
            
            currentNode = child
            currentIndex += 1
        }
        
        return currentNode
    }
    
    func getStringSuggestions(fromNode:TrieNode<Character>, withPrefix:String) -> [String] {
        var suggestions:[String] = []
        
        if fromNode.children.values.count == 0 {
            suggestions.append(withPrefix)
            return suggestions
        } else {
            
            if fromNode.isCompleteWord {
                suggestions.append(withPrefix)
            }
            
            for node : TrieNode in fromNode.children.values {
                var suggestionString = withPrefix
                suggestionString.append(node.value!)
                
                suggestions += getStringSuggestions(fromNode: node, withPrefix: suggestionString)
            }
        }
        return suggestions
    }
    
    func delete(word:String) {
        
        guard !word.isEmpty else { return }
        let currentNode = getCurrentNode(forString: word)
        delete(currentNode:currentNode)
        
    }
    
    func delete(currentNode:TrieNode <Character>){
        
        if currentNode.children.values.count == 0 {
            let parent = currentNode.parent!
            parent.children[currentNode.value!] = nil;
            delete(currentNode: parent)
        }
        else if currentNode.children.values.count > 0 && currentNode.isCompleteWord {
            currentNode.isCompleteWord = false;
        }
        else if currentNode.parent != nil {
            delete(currentNode: currentNode.parent!)
        }
    }
}

