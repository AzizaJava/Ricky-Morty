//
//  CoreDataCharactersResponseStorage.swift
//  Rick and Morty
//
//  Created by Aziza Jabrailova on 09.12.22.
//

import Foundation
import CoreData

final class CoreDataCharactersResponseStorage {

    private let coreDataStorage: CoreDataStorage

    init(coreDataStorage: CoreDataStorage = CoreDataStorage.shared) {
        self.coreDataStorage = coreDataStorage
    }

    // MARK: - Private

    private func fetchRequest(for requestDto: CharactersRequestDTO) -> NSFetchRequest<CharactersRequestEntity> {
        let request: NSFetchRequest = CharactersRequestEntity.fetchRequest()
        request.predicate = NSPredicate(format: "%K = %@ AND %K = %d",
                                        #keyPath(CharactersRequestEntity.query), requestDto.query,
                                        #keyPath(CharactersRequestEntity.page), requestDto.page)
        return request
    }

    private func deleteResponse(for requestDto: CharactersRequestDTO, in context: NSManagedObjectContext) {
        let request = fetchRequest(for: requestDto)

        do {
            if let result = try context.fetch(request).first {
                context.delete(result)
            }
        } catch {
            print(error)
        }
    }
}

extension CoreDataCharactersResponseStorage: CharactersResponseStorage {

    func getResponse(for requestDto: CharactersRequestDTO, completion: @escaping (Result<CharactersResponseDTO?, CoreDataStorageError>) -> Void) {
        coreDataStorage.performBackgroundTask { context in
            do {
                let fetchRequest = self.fetchRequest(for: requestDto)
                let requestEntity = try context.fetch(fetchRequest).first

                completion(.success(requestEntity?.response?.toDTO()))
            } catch {
                completion(.failure(CoreDataStorageError.readError(error)))
            }
        }
    }

    func save(response responseDto: CharactersResponseDTO, for requestDto: CharactersRequestDTO) {
        coreDataStorage.performBackgroundTask { context in
            do {
                self.deleteResponse(for: requestDto, in: context)

                let requestEntity = requestDto.toEntity(in: context)
                requestEntity.response = responseDto.toEntity(in: context)

                try context.save()
            } catch {
                // TODO: - Log to Crashlytics
                debugPrint("CoreDataCharactersResponseStorage Unresolved error \(error), \((error as NSError).userInfo)")
            }
        }
    }
}
