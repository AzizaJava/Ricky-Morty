//
//  CharactersResponseStorage.swift
//  Rick and Morty
//
//  Created by Aziza Jabrailova on 09.12.22.
//

import Foundation

protocol CharactersResponseStorage {
    func getResponse(for request: CharactersRequestDTO, completion: @escaping (Result<CharactersResponseDTO?, CoreDataStorageError>) -> Void)
    func save(response: CharactersResponseDTO, for requestDto: CharactersRequestDTO)
}
