//
//  Character.swift
//  Rick and Morty
//
//  Created by Aziza Jabrailova on 09.12.22.
//

import Foundation

struct Character: Equatable, Identifiable {
    typealias Identifier = String
   
    let id: Identifier
    let name: String?
    let status: String?
    let image: String?
    let gender: String?
}

struct CharactersPage: Equatable {
    let count: Int
    let pages: Int
    let results: [Character]
}
