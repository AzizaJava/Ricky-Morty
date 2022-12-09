//
//  UseCase.swift
//  Rick and Morty
//
//  Created by Aziza Jabrailova on 09.12.22.
//

import Foundation

public protocol UseCase {
    @discardableResult
    func start() -> Cancellable?
}
