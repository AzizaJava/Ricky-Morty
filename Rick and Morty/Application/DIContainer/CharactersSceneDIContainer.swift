//
//  CharactersSceneDIContainer.swift
//  Rick and Morty
//
//  Created by Aziza Jabrailova on 09.12.22.
//

import UIKit

final class CharactersSceneDIContainer {
    
    struct Dependencies {
        let apiDataTransferService: DataTransferService
    }
    
    private let dependencies: Dependencies

    // MARK: - Persistent Storage
    lazy var charactersResponseStorage: CharactersResponseStorage = CoreDataCharactersResponseStorage()

    init(dependencies: Dependencies) {
        self.dependencies = dependencies        
    }
    

    // MARK: - Flow Coordinators
       func makeCharactersFlowCoordinator(navigationController: UINavigationController) -> CharactersFlowCoordinator {
           return CharactersFlowCoordinator(navigationController: navigationController,
                                              dependencies: self)
    }
}

