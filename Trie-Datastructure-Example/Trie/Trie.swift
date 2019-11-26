//
//  Trie.swift
//  Trie-Datastructure-Example
//
//  Created by Vinodh Govind Swamy on 8/5/17.
//  Copyright © 2017 Vinodh Swamy. All rights reserved.
//

import Foundation

public protocol TrieValue {
    var key: String { get }
}

class TrieNode <Element: TrieValue> {
    var nodeCh: Character?
    var value: Element?
    var isCompleteWord: Bool = false
    var children: [Character: TrieNode] = [:]
}

public class Trie <Element: TrieValue> {
    typealias Node = TrieNode<Element>
    private var root: Node = Node()

    public func insert (item: Element) -> Bool {

        guard !item.key.isEmpty else { return false }

        let characters = Array(item.key.lowercased())
        var node = root
        for char in characters {
            if let currentNode = node.children[char] {
                node = currentNode
            } else {
                let newNode = Node()
                newNode.nodeCh = char
                node.children[char] = newNode
                node = newNode
            }
        }

        node.isCompleteWord = true
        node.value = item
        return true
    }

    public func suggestions (for string: String) -> [Element]? {
        guard let currNode = node(for: string) else { return nil }
        return getLeafNodesValues(for: currNode)
    }

    private func getLeafNodesValues(for node: Node) -> [Element]? {
        var leafNodeValues: [Element] = []

        if node.children.count == 0,
            let value = node.value,
            node.isCompleteWord {
            leafNodeValues.append(value)
            return leafNodeValues
        } else {

            if node.children.count > 0, node.isCompleteWord, let value = node.value {
                leafNodeValues.append(value)
            }

            for childNode in node.children.values {
                if let leafNodes = getLeafNodesValues(for: childNode) {
                    leafNodeValues = leafNodeValues + leafNodes
                }
            }
        }
        return leafNodeValues
    }

    private func node (for string: String) -> Node? {
        var node = root
        let characters = Array(string.lowercased())
        var index = 0
        while index < characters.count,
            let childNode = node.children[characters[index]] {
                node = childNode
                index = index + 1
        }
        return index == characters.count ? node : nil
    }

    public func delete (item: Element) -> Bool {

        var node = root
        let characters = Array(item.key.lowercased())
        var index = 0
        let stack = Stack()
        while index < characters.count,
            let childNode = node.children[characters[index]] {
            node = childNode
            stack.push(item: node)
            index = index + 1
        }

        guard index == characters.count else { return false }

        if node.isCompleteWord {
            node.isCompleteWord = false
            node.value = nil
        }

        while !stack.isStackEmpty {
            if let node = stack.pop() as? Node {
                if node.children.count == 0,
                    !node.isCompleteWord,
                    let ch = node.nodeCh,
                    let parentNode = stack.top as? Node {
                    parentNode.children[ch] = nil
                }
            }
        }


        return true
    }
}

extension String: TrieValue {
    public var key: String {
        return self
    }
}


fileprivate class Stack {
    private var items: [Any] = []
    func push(item: Any){
        items.append(item)
    }

    var top: Any? {
        return items.last
    }

    func pop() -> Any {
        let item = items.removeLast()
        return item
    }

    var isStackEmpty: Bool {
        return items.isEmpty
    }
}
