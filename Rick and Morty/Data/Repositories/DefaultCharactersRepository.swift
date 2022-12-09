//
//  DefaultCharactersRepository.swift
//  Rick and Morty
//
//  Created by Aziza Jabrailova on 09.12.22.
//

import Foundation

final class DefaultCharactersRepository {

    private let dataTransferService: DataTransferService
    private let cache: CharactersResponseStorage

    init(dataTransferService: DataTransferService, cache: CharactersResponseStorage) {
        self.dataTransferService = dataTransferService
        self.cache = cache
    }
}

extension DefaultCharactersRepository: CharactersRepository {

    public func fetchCharactersList(query: CharacterQuery, page: Int,
                                cached: @escaping (CharactersPage) -> Void,
                                completion: @escaping (Result<CharactersPage, Error>) -> Void) -> Cancellable? {

        let requestDTO = CharactersRequestDTO(query: query.query, page: page)
        let task = RepositoryTask()

        cache.getResponse(for: requestDTO) { result in

            if case let .success(responseDTO?) = result {
                cached(responseDTO.toDomain())
            }
            guard !task.isCancelled else { return }

            let endpoint = APIEndpoints.getCharacters(with: requestDTO)
            task.networkTask = self.dataTransferService.request(with: endpoint) { result in
                switch result {
                case .success(let responseDTO):
                    self.cache.save(response: responseDTO, for: requestDTO)
                    completion(.success(responseDTO.toDomain()))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
        return task
    }
}
