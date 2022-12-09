//
//  CharactersRepository.swift
//  Rick and Morty
//
//  Created by Aziza Jabrailova on 09.12.22.
//

import Foundation

protocol CharactersRepository {
    @discardableResult
    func fetchCharactersList(query: CharacterQuery, page: Int,
                         cached: @escaping (CharactersPage) -> Void,
                         completion: @escaping (Result<CharactersPage, Error>) -> Void) -> Cancellable?
}
