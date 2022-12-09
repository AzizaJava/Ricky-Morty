//
//  CharacterDetailViewModel.swift
//  Rick and Morty
//
//  Created by Aziza Jabrailova on 09.12.22.
//

import Foundation

protocol CharacterDetailViewModelInput {
   
}

protocol CharacterDetailViewModelOutput {
    var name: String { get }
    var image: Observable<Data?> { get }
    var status: String { get }
    var gender: String { get }
}

protocol CharacterDetailViewModel: CharacterDetailViewModelOutput { }

final class DefaultCharacterDetailViewModel: CharacterDetailViewModel {
    
    private let posterImagePath: String?
    private var imageLoadTask: Cancellable? { willSet { imageLoadTask?.cancel() } }

    // MARK: - OUTPUT
    let name: String
    let image: Observable<Data?> = Observable(nil)
    let status: String
    let gender: String
    
    init(character: Character) {
        self.name = character.name ?? ""
        self.status = character.status ?? ""
        self.image = character.image
        self.gender = character.gender ?? ""
    }
}

