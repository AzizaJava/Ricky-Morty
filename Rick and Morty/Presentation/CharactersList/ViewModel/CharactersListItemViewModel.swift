//
//  CharactersListItemViewModel.swift
//  Rick and Morty
//
//  Created by Aziza Jabrailova on 09.12.22.
//

import Foundation

struct CharactersListItemViewModel: Equatable {
    let name: String
    let status: String
    let gender: String
    let imagePath: String?
}

extension CharactersListItemViewModel {

    init(character: Character) {
        self.name = character.name ?? ""
        self.imagePath = character.image
        self.gender = character.gender ?? ""
        self.status = character.status ?? ""
    }
}

