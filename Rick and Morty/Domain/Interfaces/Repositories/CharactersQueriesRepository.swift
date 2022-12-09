//
//  CharactersQueriesRepository.swift
//  Rick and Morty
//
//  Created by Aziza Jabrailova on 09.12.22.
//

import Foundation

protocol CharactersQueriesRepository {
    func fetchRecentsQueries(maxCount: Int, completion: @escaping (Result<[CharacterQuery], Error>) -> Void)
    func saveRecentQuery(query: CharacterQuery, completion: @escaping (Result<CharacterQuery, Error>) -> Void)
}
