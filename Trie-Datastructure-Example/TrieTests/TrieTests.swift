//
//  TrieTests.swift
//  TrieTests
//
//  Created by Vinodh Govindaswamy on 27/11/19.
//  Copyright © 2019 Vinodh Swamy. All rights reserved.
//

import XCTest
@testable import Trie

class TrieTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testTrieWithString() {
        let trie = Trie<String>()
        XCTAssertTrue(trie.insert(item: "Cat"))
        XCTAssertTrue(trie.insert(item: "Cat"))
        XCTAssertTrue(trie.insert(item: "Car"))
        XCTAssertTrue(trie.insert(item: "Cart"))
        XCTAssertTrue(trie.insert(item: "Cars"))
        XCTAssertTrue(trie.insert(item: "Cate"))
        XCTAssertTrue(trie.insert(item: "Bat"))
        XCTAssertTrue(trie.insert(item: "Bats"))
        XCTAssertTrue(trie.insert(item: "Ball"))

        let suggestionFor_CA = trie.suggestions(for: "ca") ?? [""]
        XCTAssertEqual(suggestionFor_CA.sorted(), ["Car", "Cars", "Cart", "Cat", "Cate"])

        let suggestionFor_BAT = trie.suggestions(for: "bat") ?? [""]
        XCTAssertEqual(suggestionFor_BAT.sorted(), ["Bat", "Bats"])

        let suggestionFor_BALL = trie.suggestions(for: "ball") ?? [""]
        XCTAssertEqual(suggestionFor_BALL.sorted(), ["Ball"])
    }



    func testTrieWithCustomObject() {
        let peopleTrie = Trie<Person>()
        let john = Person(inFirstName: "John", inLastName: "Carter", inContact: "234234")
        let joe = Person(inFirstName: "Joe", inLastName: "Luke", inContact: "234244")
        let joes = Person(inFirstName: "Joes", inLastName: "Cashin", inContact: "234244")
        let jake = Person(inFirstName: "Jake", inLastName: "William", inContact: "234254")
        let julian = Person(inFirstName: "Jalian", inLastName: "Thomas", inContact: "32423")

        _ = peopleTrie.insert(item: john)
        _ = peopleTrie.insert(item: joe)
        _ = peopleTrie.insert(item: joes)
        _ = peopleTrie.insert(item: jake)
        _ = peopleTrie.insert(item: julian)

        if let personSuggestions = peopleTrie.suggestions(for: "j") {
            XCTAssertEqual(personSuggestions.map { $0.firstName }.sorted(), ["Jake", "Jalian", "Joe", "Joes", "John"])
        }
        if let personSuggestions = peopleTrie.suggestions(for: "jo") {
            XCTAssertEqual(personSuggestions.map { $0.firstName }.sorted(), ["Joe", "Joes", "John"])
        }
        if let personSuggestions = peopleTrie.suggestions(for: "ja") {
            XCTAssertEqual(personSuggestions.map { $0.firstName }.sorted(), ["Jake", "Jalian"])
        }

        print("\nDelete Joes")
        if peopleTrie.delete(item: joes), let personSuggestions = peopleTrie.suggestions(for: "j") {
            XCTAssertEqual(personSuggestions.map { $0.firstName }.sorted(), ["Jake", "Jalian", "Joe", "John"])
        }

        print("\nDelete Jake")
        if peopleTrie.delete(item: jake), let personSuggestions = peopleTrie.suggestions(for: "j") {
            XCTAssertEqual(personSuggestions.map { $0.firstName }.sorted(), ["Jalian", "Joe", "John"])
        }

    }
}
