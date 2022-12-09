//
//  CharactersListItemCell.swift
//  Rick and Morty
//
//  Created by Aziza Jabrailova on 09.12.22.
//

import UIKit

final class CharactersListItemCell: UITableViewCell {

    static let reuseIdentifier = String(describing: CharactersListItemCell.self)
    static let height = CGFloat(130)

    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var statusLabel: UILabel!
    @IBOutlet private var genderLabel: UILabel!
    @IBOutlet private var posterImageView: UIImageView!

    private var viewModel: CharactersListItemViewModel!
    private var imageLoadTask: Cancellable? { willSet { imageLoadTask?.cancel() } }

    func fill(with viewModel: CharactersListItemViewModel) {
        self.viewModel = viewModel

        nameLabel.text = viewModel.name
        statusLabel.text = viewModel.status
        genderLabel.text = viewModel.gender
    }

   
}
