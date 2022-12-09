//
//  CharactersFlowCoordinator.swift
//  Rick and Morty
//
//  Created by Aziza Jabrailova on 09.12.22.
//

import UIKit

protocol CharactersFlowCoordinatorDependencies  {
    func makeCharactersListViewController(actions: CharactersListViewModelActions) -> CharactersListViewController
    func makeCharacterDetailViewController(character: Character) -> UIViewController
}

final class CharactersFlowCoordinator {
    
    private weak var navigationController: UINavigationController?
    private let dependencies: CharactersFlowCoordinatorDependencies
    private weak var charactersListVC: CharactersListViewController?

    init(navigationController: UINavigationController,
         dependencies: CharactersFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        let actions = CharactersListViewModelActions(showCharacterDetail: showCharacterDetail)
        let vc = dependencies.makeCharactersListViewController(actions: actions)
        navigationController?.pushViewController(vc, animated: false)
        charactersListVC = vc
    }

    private func showCharacterDetail(character: Character) {
        let vc = dependencies.makeCharacterDetailViewController(character: character)
        navigationController?.pushViewController(vc, animated: true)
    }

}
