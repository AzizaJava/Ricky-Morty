//
//  CharactersListViewModel.swift
//  Rick and Morty
//
//  Created by Aziza Jabrailova on 09.12.22.
//

import Foundation

struct CharactersListViewModelActions {
  
    let showCharacterDetail: (Character) -> Void
}

enum CharactersListViewModelLoading {
    case fullScreen
    case nextPage
}

protocol CharactersListViewModelInput {
    func viewDidLoad()
    func didLoadNextPage()
    func didSearch(query: String)
    func didCancelSearch()
    func showQueriesSuggestions()
    func closeQueriesSuggestions()
    func didSelectItem(at index: Int)
}

protocol CharactersListViewModelOutput {
    var items: Observable<[CharactersListItemViewModel]> { get } 
    var loading: Observable<CharactersListViewModelLoading?> { get }
    var query: Observable<String> { get }
    var error: Observable<String> { get }
    var isEmpty: Bool { get }
    var screenTitle: String { get }
    var emptyDataTitle: String { get }
    var errorTitle: String { get }
}

protocol CharactersListViewModel: CharactersListViewModelInput, CharactersListViewModelOutput {}

final class DefaultCharactersListViewModel: CharactersListViewModel {

    private let actions: CharactersListViewModelActions?

    var currentPage: Int = 0
    var totalPageCount: Int = 1
    var hasMorePages: Bool { currentPage < totalPageCount }
    var nextPage: Int { hasMorePages ? currentPage + 1 : currentPage }

    private var pages: [CharactersPage] = []
    private var charactersLoadTask: Cancellable? { willSet { charactersLoadTask?.cancel() } }

    // MARK: - OUTPUT

    let items: Observable<[CharactersListItemViewModel]> = Observable([])
    let loading: Observable<CharactersListViewModelLoading?> = Observable(.none)
    let query: Observable<String> = Observable("")
    let error: Observable<String> = Observable("")
    var isEmpty: Bool { return items.value.isEmpty }
    let screenTitle = NSLocalizedString("Characters", comment: "")
    let emptyDataTitle = NSLocalizedString("Search results", comment: "")
    let errorTitle = NSLocalizedString("Error", comment: "")

    // MARK: - Init

    init(actions: CharactersListViewModelActions? = nil) {
        self.actions = actions
    }

    // MARK: - Private

    private func appendPage(_ charactersPage: CharactersPage) {
        currentPage = charactersPage.page
        totalPageCount = charactersPage.totalPages

        pages = pages
            .filter { $0.page != charactersPage.page }
            + [charactersPage]

        items.value = pages.characters.map(CharactersListItemViewModel.init)
    }

    private func resetPages() {
        currentPage = 0
        totalPageCount = 1
        pages.removeAll()
        items.value.removeAll()
    }

    private func load(characterQuery: CharacterQuery, loading: CharactersListViewModelLoading) {
        self.loading.value = loading
        query.value = characterQuery.query

    }

    private func handle(error: Error) {
        self.error.value = error.isInternetConnectionError ?
            NSLocalizedString("No internet connection", comment: "") :
            NSLocalizedString("Failed loading characters", comment: "")
    }

    private func update(characterQuery: CharacterQuery) {
        resetPages()
        load(characterQuery: characterQuery, loading: .fullScreen)
    }
}

// MARK: - INPUT. View event methods

extension DefaultCharactersListViewModel {

    func viewDidLoad() { }

    func didLoadNextPage() {
        guard hasMorePages, loading.value == .none else { return }
        load(characterQuery: .init(query: query.value),
             loading: .nextPage)
    }

    func didSearch(query: String) {
        guard !query.isEmpty else { return }
        update(characterQuery: CharacterQuery(query: query))
    }

    func didCancelSearch() {
        charactersLoadTask?.cancel()
    }


    func didSelectItem(at index: Int) {
        actions?.showCharacterDetail(pages.characters[index])
    }
}

// MARK: - Private

private extension Array where Element == CharacterQuery {
    var characters: [Character] { flatMap { $0.characters } }
}

