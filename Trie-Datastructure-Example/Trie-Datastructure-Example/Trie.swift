//
//  Trie.swift
//  Trie-Datastructure-Example
//
//  Created by Vinodh Govind Swamy on 8/5/17.
//  Copyright © 2017 Vinodh Swamy. All rights reserved.
//

import Foundation

protocol TrieValue: Hashable {
    var trieKey:String { get }
}

class TrieNode < Element:TrieValue> {
    var nodeCh : Character?
    var value  : Element?
    weak var parent : TrieNode?
    var children : [Character:TrieNode] = [:]
    var isCompleteWord : Bool = false
    init(inNodeCh:Character? = nil, inValue:Element? = nil, inParent:TrieNode? = nil) {
        nodeCh = inNodeCh
        value = inValue
        parent = inParent
    }
    
    func add(newNodeKey : Character) {
        
        guard children[newNodeKey] == nil else { return }
        children[newNodeKey] = TrieNode(inNodeCh: newNodeKey, inParent: self)
    }
}

class Trie <Element:TrieValue> {
    typealias Node = TrieNode<Element>
    fileprivate let root : Node
    init() {
        root = Node()
    }
}

extension Trie {
    func insert(item : Element) {
        
        guard !item.trieKey.isEmpty else { return }
        
        var currentNode = root
        var currentIndex = 0;
        let characters = Array(item.trieKey.lowercased().characters)
        
        while currentIndex < characters.count {
            let nodeChar = characters[currentIndex]
            if let child = currentNode.children[nodeChar] {
                currentNode = child
            } else {
                currentNode.add(newNodeKey: nodeChar)
                currentNode = currentNode.children[nodeChar]!
            }
            currentIndex += 1
        }
        
        if currentIndex == characters.count {
            currentNode.isCompleteWord = true
            currentNode.value = item
        }
    }
    
    func contains(element : Element) -> Bool {
        var containsWord = false
        guard !element.trieKey.isEmpty else { return  containsWord }
        
        var currentIndex = 0
        var currentNode = root
        let characters = Array(element.trieKey.lowercased().characters)
        
        while currentIndex < characters.count, let child = currentNode.children[characters[currentIndex]] {
            currentNode = child
            currentIndex += 1
        }
        
        if currentIndex == characters.count && currentNode.isCompleteWord {
            containsWord = true
        }
        
        return containsWord
    }
    
    func getSuggestions(forString:String) -> [Element] {
        var suggestions : [Element] = []
        
        guard !forString.isEmpty else { return  suggestions }
        
        let currentNode = getCurrentNode(forString:forString)
        
        suggestions += getStringSuggestions(fromNode: currentNode)
        
        return suggestions
    }
    
    func getCurrentNode(forString:String) -> TrieNode <Element> {
        
        var currentIndex = 0
        var currentNode = root
        let characters = Array(forString.lowercased().characters)
        
        while currentIndex < characters.count, let child = currentNode.children[characters[currentIndex]] {
            
            currentNode = child
            currentIndex += 1
        }
        
        return currentNode
    }
    
    func getStringSuggestions(fromNode:TrieNode<Element>) -> [Element] {
        var suggestions:[Element] = []
        
        if fromNode.children.values.count == 0 && fromNode.value != nil {
            suggestions.append(fromNode.value!)
            return suggestions
        } else {
            
            if fromNode.isCompleteWord && fromNode.value != nil {
                suggestions.append(fromNode.value!)
            }
            
            for node : TrieNode in fromNode.children.values {
                suggestions += getStringSuggestions(fromNode: node)
            }
        }
        return suggestions
    }
}

