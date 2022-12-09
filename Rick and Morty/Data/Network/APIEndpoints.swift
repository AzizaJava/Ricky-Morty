//
//  APIEndpoints.swift
//  Rick and Morty
//
//  Created by Aziza Jabrailova on 09.12.22.
//

import Foundation

struct APIEndpoints {
    
    static func getCharactersList(with charactersRequestDTO: CharactersRequestDTO) -> Endpoint<CharactersRequestDTO> {

        return Endpoint(path: "api/character",
                        method: .get,
                        queryParametersEncodable: charactersRequestDTO)
    }

    static func getCharacterDetail(index: String) -> Endpoint<Data> {
        return Endpoint(path: "api/character/\(index)",
                        method: .get,
                        responseDecoder: RawDataResponseDecoder())
    }
}
