//
//  CharactersResponseDTO+Mapping.swift
//  Rick and Morty
//
//  Created by Aziza Jabrailova on 09.12.22.
//

import Foundation

// MARK: - Data Transfer Object

struct CharactersResponseDTO: Decodable {
    let count: Int
    let pages: Int
    let results: [CharacterDTO]
}

extension CharactersResponseDTO {
    struct CharacterDTO: Decodable {
        let id: Int
        let name: String?
        let status: String?
        let gender: String?
        let image: String?
    }
}


