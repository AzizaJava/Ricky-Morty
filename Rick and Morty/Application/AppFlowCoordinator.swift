//
//  AppFlowCoordinator.swift
//  Rick and Morty
//
//  Created by Aziza Jabrailova on 09.12.22.
//


import UIKit

final class AppFlowCoordinator {

    var navigationController: UINavigationController
    private let appDIContainer: AppDIContainer
    
    init(navigationController: UINavigationController,
         appDIContainer: AppDIContainer) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
    }

    func start() {
        // In App Flow we can check if user needs to login, if yes we would run login flow
        let charactersSceneDIContainer = appDIContainer.makeCharactersSceneDIContainer()
        let flow = charactersSceneDIContainer.makeCharactersFlowCoordinator(navigationController: navigationController)
        flow.start()
    }
}

