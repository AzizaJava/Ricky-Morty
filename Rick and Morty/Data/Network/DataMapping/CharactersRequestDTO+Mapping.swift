//
//  CharactersRequestDTO+Mapping.swift
//  Rick and Morty
//
//  Created by Aziza Jabrailova on 09.12.22.
//

import Foundation

struct CharactersRequestDTO: Encodable {
    let query: Int
    let page: Int
}
