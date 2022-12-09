//
//  DIContainer.swift
//  Rick and Morty
//
//  Created by Aziza Jabrailova on 09.12.22.
//

import Foundation

final class AppDIContainer {
    
    lazy var appConfiguration = AppConfiguration()
    
    // MARK: - Network
    lazy var apiDataTransferService: DataTransferService = {
        let config = ApiDataNetworkConfig(baseURL: URL(string: appConfiguration.apiBaseURL)!)
        
        let apiDataNetwork = DefaultNetworkService(config: config)
        return DefaultDataTransferService(with: apiDataNetwork)
    }()
   
    // MARK: - DIContainers of scenes
    func makeCharactersSceneDIContainer() -> CharactersSceneDIContainer {
        let dependencies = CharactersSceneDIContainer.Dependencies(apiDataTransferService: apiDataTransferService)
        return CharactersSceneDIContainer(dependencies: dependencies)
    }
}
